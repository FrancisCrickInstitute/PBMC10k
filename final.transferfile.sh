


if {!dir.exits /camp/stp/babs/www/boeings/bioLOGIC_external/data/vpl362A/html/report_tables}{
    mkdir -p /camp/stp/babs/www/boeings/bioLOGIC_external/data/vpl362A/html/report_tables
}




cp -r /camp/stp/babs/working/boeings/Projects/pachnisv/yuuki.obata/409_sc_RNA_seq_enteric_glia_neuron_Regev_SC1038/workdir/sc_dev/sc_PartB_Analysis.html /camp/stp/babs/www/boeings/bioLOGIC_external/data/vpl409/html/Analysis_V1.html
cp -r /camp/stp/babs/working/boeings/Projects/pachnisv/yuuki.obata/409_sc_RNA_seq_enteric_glia_neuron_Regev_SC1038/workdir/vpl409/report_figures /camp/stp/babs/www/boeings/bioLOGIC_external/data/vpl409/html/


mkdir -p /camp/stp/babs/www/boeings/bioLOGIC_external/data/vpl409/html/report_tables
cp -r /camp/stp/babs/working/boeings/Projects/pachnisv/yuuki.obata/409_sc_RNA_seq_enteric_glia_neuron_Regev_SC1038/workdir/sc_dev/sampleAnnotation.txt
cp -r /camp/stp/babs/working/boeings/Projects/pachnisv/yuuki.obata/409_sc_RNA_seq_enteric_glia_neuron_Regev_SC1038/workdir/sc_dev/clusterAnnotation.txt 