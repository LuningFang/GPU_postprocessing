#!/bin/sh
mus_array=(0.3 0.4 0.5 0.6 0.7 0.8 0.9 0.95)

for id in 0 1 2 3 4 5
  do
			mus=${mus_array[$id]}
			filedir="/srv/home/fang/Build/cosim/bin/DEMO_OUTPUT/RIG_COSIM/RIGID_GRANULAR_GPU/HCP_SEP1.001/RIG_hcp_sep_1.001_mus=${mus}"
			filename="${filedir}/results.dat"
			echo ${filename}
			scp euler2:${filename} .
		  newname="mus=${mus}.dat"
			echo "new file name: ${newname}"
			mv "results.dat" ${newname}
		  filedir="/srv/home/fang/Build/cosim/bin/DEMO_OUTPUT/RIG_COSIM/RIGID_GRANULAR_GPU/HCP_SEP1.001/TERRAIN_hcp_sep_1.001_mus=${mus}"
		  particle_filename="${filedir}/checkpoint_settled.dat"
			scp euler2:${particle_filename} .
			echo "download ${particle_filename}"
			newname="mus=${mus}_settled.dat"
			mv "checkpoint_settled.dat" ${newname}
  done
