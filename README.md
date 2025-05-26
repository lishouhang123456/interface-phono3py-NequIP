# interface-phono3py-NequIP

When we calculate the 3rd-order FCs, we use NequIP to generate the forces.

INPUT: SSCHA dynamical matrices

# Generate POSCAR file
phono3py gen_poscar.py

# Generate random supercell file
phono3py gen_config.py

# Generate phono3py_disp.yaml
phono3py --qe --rd **1000** --dim 4 4 4 --pa auto -c scf.in
# 1000 is the number of random configuration. It should be the same as that in gen_config.py

# Change the data structure of the displacement from QE

matlab gen_disp.m


