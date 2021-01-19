wait_on_lsf() { ## wait on jobs{
sleep 300
n=`squeue --name=$project  | wc -l`
while [ $n -ne 1 ]
do
n=`squeue --name=$project  | wc -l`
((z=$n-1))
#number of running
echo "$project jobs running: $z"
#number of pending
sleep 300
done
}

project=rA418

sbatch --time=12:00:00 --wrap "module purge;source /camp/stp/babs/working/software/modulepath_new_software_tree_2018-08-13;module load pandoc/2.2.3.2-foss-2016b;ml R/3.6.0-foss-2016b-BABS;Rscript runA.r" --job-name=$project -p hmem --mem=300G -o rA.slurm >> commands.txt


##wait on jobs
wait_on_lsf
project=rCF409
sbatch --time=18:00:00 --wrap "module purge;source /camp/stp/babs/working/software/modulepath_new_software_tree_2018-08-13;module load pandoc/2.2.3.2-foss-2016b;ml R/3.6.0-foss-2016b-BABS;Rscript runCM.r" --job-name=$project -p hmem --mem=300G -o rCN.slurm >> commands.txt

project=rB409
sbatch --time=18:00:00 --wrap "module purge;source /camp/stp/babs/working/software/modulepath_new_software_tree_2018-08-13;module load pandoc/2.2.3.2-foss-2016b;ml R/3.6.0-foss-2016b-BABS;Rscript runB.r" --job-name=$project -p hmem --mem=300G -o rB.slurm >> commands.txt

project=rDGE409
sbatch --time=18:00:00 --wrap "module purge;source /camp/stp/babs/working/software/modulepath_new_software_tree_2018-08-13;module load pandoc/2.2.3.2-foss-2016b;ml R/3.6.0-foss-2016b-BABS;Rscript runDGE.r" --job-name=$project -p hmem --mem=300G -o rDGE.slurm >> commands.txt

#project=rC409
#sbatch --time=12:00:00 --wrap "module purge;source /camp/stp/babs/working/software/modulepath_new_software_tree_2018-08-13;module load pandoc/2.2.3.2-foss-2016b;ml R/3.6.0-foss-2016b-BABS;Rscript runC.r" --job-name=$project  --mem=100G -o rC.slurm >> commands.txt

sbatch --time=12:00:00 --wrap "module purge;source /camp/stp/babs/working/software/modulepath_new_software_tree_2018-08-13;module load pandoc/2.2.3.2-foss-2016b;ml R/3.6.0-foss-2016b-BABS;Rscript runC.r" --job-name=$project -p hmem --mem=300G -o rC.slurm >> commands.txt