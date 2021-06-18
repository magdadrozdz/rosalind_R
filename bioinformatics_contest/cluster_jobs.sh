qsub -pe shmem 5 generic_rscript.sh $(readlink -f ./data_download_processing/trial_data_processing.R)

qsub -pe shmem 5 generic_rscript.sh $(readlink -f ./data_download_processing/trial_data_processing_minimal.R)

qsub -pe shmem 5 generic_rscript.sh $(readlink -f ./data_download_processing/ludwig_data_processing_minimal.R)

qsub -pe shmem 9 generic_rscript.sh $(readlink -f ./block_processing/A01_clustering_sites.R)

qsub -pe shmem 5 generic_rscript.sh $(readlink -f ./block_processing/B01_select_info_blocks.R)




qsub run_nmf.sh $(readlink -f C01_run_nmf.R) 9
qsub run_nmf.sh $(readlink -f C01_run_nmf.R) 10
qsub run_nmf.sh $(readlink -f C01_run_nmf.R) 11
qsub run_nmf.sh $(readlink -f C01_run_nmf.R) 12
qsub run_nmf.sh $(readlink -f C01_run_nmf.R) 13
qsub run_nmf.sh $(readlink -f C01_run_nmf.R) 14
qsub run_nmf.sh $(readlink -f C01_run_nmf.R) 15
