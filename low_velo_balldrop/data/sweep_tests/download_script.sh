#!/bin/sh
mur_array=(0.00 0.05 0.09 0.20)

euler_filedir="/srv/home/fang/Build/balldrop/bin/"
jeff_dir="${HOME}/Source/granularTests_postprocessing/low_velo_balldrop/data/sweep_tests/"
for ii in 0 1 2 3
  do
			mur=${mur_array[$ii]}
			cd "${jeff_dir}mur_${mur}"
			scp euler2:${euler_filedir}bc_sphere_result_mur_${mur}* .
  done
