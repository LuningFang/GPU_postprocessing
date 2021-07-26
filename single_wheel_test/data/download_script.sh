#!/bin/sh
mus_array=(0.7 0.7 0.8 0.8 0.9 0.9)
mur_array=(0.3 0.4 0.3 0.4 0.3 0.4)


for id in 0 1 2 3 4 5
  do
			mus=${mus_array[$id]}
			mur=${mur_array[$id]}
			filedir="/srv/home/fang/Build/cosim/bin/DEMO_OUTPUT/RIG_COSIM/RIGID_GRANULAR_GPU/RIG_s2m_mus=${mus}_mur=${mur}"
			filename="${filedir}/results.dat"
			echo ${filename}
			scp euler2:${filename} .
		  newname="mus=${mus}_mur=${mur}_rig.dat"
			echo "new file name: ${newname}"
			mv "results.dat" ${newname}
		  filedir="/srv/home/fang/Build/cosim/bin/DEMO_OUTPUT/RIG_COSIM/RIGID_GRANULAR_GPU/TERRAIN_s2m_mus=${mus}_mur=${mur}"
		  particle_filename="${filedir}/checkpoint_settled.dat"
			scp euler2:${particle_filename} .
			echo "download ${particle_filename}"
			newname="mus=${mus}_mur=${mur}_settled.dat"
			mv "checkpoint_settled.dat" ${newname}
  done
