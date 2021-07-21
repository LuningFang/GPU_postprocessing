#!/bin/sh
slip_array_in=(-0.7 -0.5 -0.3 -0.1 0 0.1 0.3 0.5 0.7)
slip_array_out=(-0.7 -0.5 -0.3 -0.1 0.0 0.1 0.3 0.5 0.7)

for id in 0 1 2 3 4 5 6 7 8
  do
	slip=${slip_array_in[$id]}
	filedir="/srv/home/fang/Build/cosim/bin/DEMO_OUTPUT/RIG_COSIM/RIGID_GRANULAR_GPU/RIG_mur_15e-2_slip=${slip}"
	filename="${filedir}/results.dat"
	echo ${filename}
	scp euler2:${filename} .
	newname="slip=${slip_array_out[$id]}.dat"
	echo "new file name: ${newname}"
	mv "results.dat" ${newname}
  done
