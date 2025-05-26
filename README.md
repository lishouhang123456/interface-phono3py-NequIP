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

# Replace the phono3py displacement in file phono3py_disp.yaml by the SSCHA displacement

replace_ph3_with_sscha_disp.sh

# Run NequIP
num_config_perfile=500
num_atm=128
num_config=1000
num_iter=$((num_config / num_config_perfile))
num_line=$((num_atm + 2))
file_name=config1.xyz
for i in $(seq 1 2); do
tmp_file_name=config_$((i * num_config_perfile)).xyz
sed -n "1,$((num_config_perfile * num_line))p" $file_name > $tmp_file_name
sed -i "1,$((num_config_perfile * num_line))d" $file_name
sed -i "/dataset_file_name/c\\dataset_file_name: ${tmp_file_name}" nn_train.yaml
out_file=out$i.xyz
nequip-evaluate --model Si-bulk.pth --dataset-config nn_train.yaml --batch-size 3 --output $out_file 
done

# extract NequIP forces and transform it to Quantum Espresso format
matlab ext_xyz




