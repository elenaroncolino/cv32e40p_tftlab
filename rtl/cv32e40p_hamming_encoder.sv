module ecc_enc #(
  parameter K       = 32, //Information bit vector size
  parameter P0_LSB  = 1, //0: p0 is located at MSB
                         //1: p0 is located at LSB

  //these should be localparams
  parameter m = calculate_m(K),
  parameter n = m + K
)
(
  input  [K-1:0] d_i,      //information bit vector input
  output [n  :0] q_o,      //encoded data word output

  output [m  :1] p_o,      //parity vector output
  output         p0_o      //extended parity bit
);


//---------------------------------------------------------
// Functions
//---------------------------------------------------------
function integer calculate_m;
  input integer k;

  integer m;
begin
  m=1;
  while (2**m < m+k+1) m++;

  calculate_m = m;
end
endfunction //calculate_m


function [n:1] store_dbits_in_codeword;
  input [K-1:0] d;

  integer bit_idx, cw_idx;
begin
    //This function puts the information bits vector in the correct location
    //Information bits are stored in non-power-of-2 locations

    //clear all bits
    store_dbits_in_codeword = 0;

    bit_idx=0; //information vector bit index
    for (cw_idx=1; cw_idx<=n; cw_idx++)
      if (2**$clog2(cw_idx) != cw_idx)
        store_dbits_in_codeword[cw_idx] = d[bit_idx];
        bit_idx++;
end
endfunction //store_dbits_in_codeword


function [m:1] calculate_p;
  input [n:1] cw;

  integer p_idx, cw_idx;
begin
    //clear p
    calculate_p = 0;

    for (p_idx =1; p_idx <=m; p_idx++)  //parity-index
    for (cw_idx=1; cw_idx<=n; cw_idx++) //codeword-index
      if (|(2**(p_idx-1) & cw_idx)) calculate_p[p_idx] = calculate_p[p_idx] ^ cw[cw_idx];
end
endfunction //calculate_p


function [n:1] store_p_in_codeword;
  input [n:1] cw;
  input [m:1] p;

  integer i;
begin
    //databits don't change ... copy into codeword
    store_p_in_codeword = cw;

    //put parity vector at power-of-2 locations
    for (i=1; i<=m; i=i+1)
      store_p_in_codeword[2**(i-1)] = p[i];
end
endfunction //store_p_in_codeword


//---------------------------------------------------------
// Variables
//---------------------------------------------------------
logic [n:1] cw_w_dbits; //codeword with loaded data bits
logic [n:1] cw;         //codeword with information + parity bits
 
//Step 1: Load all databits in codeword
assign cw_w_dbits = store_dbits_in_codeword(d_i);

//Step 2: Calculate p-vector
assign p_o = calculate_p(cw_w_dbits);

//Step 3: Store p-vector in codeword
assign cw = store_p_in_codeword(cw_w_dbits, p_o);

//Step 4: Calculate p0 (extended parity bit)
//        and store it in the codeword
assign p0_o = ^cw;
assign q_o  = P0_LSB ? {cw,p0_o} : {p0_o,cw};

endmodule