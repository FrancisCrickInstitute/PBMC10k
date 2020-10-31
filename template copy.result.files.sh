

mkdir /camp/stp/babs/www/boeings/bioLOGIC_external/data/vpl362A


cp -r /camp/stp/babs/working/boeings/Projects/pachnisv/tiffany.heanue/362A_10X_single_cell_RNA_seq_enteric_neurons_nuclei_rerun_SC18139/workdir/sc_dev/sc_PartA_QC.html /camp/stp/babs/www/boeings/bioLOGIC_external/data/vpl362A/QC.html
mv /camp/stp/babs/working/boeings/Projects/pachnisv/tiffany.heanue/362A_10X_single_cell_RNA_seq_enteric_neurons_nuclei_rerun_SC18139/workdir/sc_dev/sc_PartA_QC.html .. 




### bulk-RNA-Seq copy file ###

###############################################################################
## Set Function                                                              ##

wait_for_cluster() { ## wait on jobs{
sleep 300
n=`squeue --name=$project  | wc -l`
while [ $n -ne 1 ] 
    do
        n=`squeue | grep $project  | wc -l`
        ((z=$n-1))
        #number of running
        echo "$project jobs running: $z"
        #number of pending
        sleep 100
    done
}

## Done setting function                                                     ##
###############################################################################


module purge;source /camp/stp/babs/working/software/modulepath_new_software_tree_2018-08-13;module load p
andoc/2.2.3.2-foss-2016b;ml R/3.6.0-foss-2016b-BABS;



Rscript /camp/stp/babs/working/boeings/Projects/leys/joan.manils/378_SLL_PO_bulkRNAseq_Psoriasis_PV_AD_GSE121212/workdir/bulkRNA_seq/bulkRNAseq_partA_Ini.r

project=rB
sh /camp/stp/babs/working/boeings/Projects/leys/joan.manils/378_SLL_PO_bulkRNAseq_Psoriasis_PV_AD_GSE121212/workdir/GSEA/GSEAcommands.sh
wait_for_cluster


## Once GSEA is finished ##
project=GSEA
sh /camp/stp/babs/working/boeings/Projects/niakank/claudia.gerri/279A_KN_CG_scRNAseq_GSE36552_human_embryo_pluripotency/workdir/bulkRNA_seq/runB2.sh
wait_for_cluster


project=rB2
sh /camp/stp/babs/working/boeings/Projects/niakank/claudia.gerri/279A_KN_CG_scRNAseq_GSE36552_human_embryo_pluripotency/workdir/bulkRNA_seq/runB2.sh
wait_for_cluster

## Re-organise GSEA ##
sh /camp/stp/babs/working/boeings/Projects/leys/joan.manils/378_SLL_PO_bulkRNAseq_Psoriasis_PV_AD_GSE121212/workdir/GSEA/GSEAmasterscript.sh
cp -r /camp/stp/babs/working/boeings/Projects/leys/joan.manils/378_SLL_PO_bulkRNAseq_Psoriasis_PV_AD_GSE121212/workdir/GSEA/enrichment_plots /camp/stp/babs/www/boeings/bioLOGIC_external/data/sll378/outputs

