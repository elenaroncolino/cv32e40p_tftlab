#tar -xf syn.tar.gz

cd ..
make clean
make synthesis/nangate45
make questa/compile	
make compile_sbst
make questa/lsim/gate/shell  
make zoix/compile
make zoix/lsim                       
make zoix/fgen/saf					                
make zoix/fsim FAULT_LIST=run/zoix/cv32e40p_top_saf.rpt 