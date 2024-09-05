params.blast_db = "$projectDir/MIDORI2_UNIQ_NUC_GB259_srRNA_BLAST"
params.query_fasta = "$projectDir/physalia_MiFish_apscale_apscale_OTU_table_filtered.fasta"
params.outdir = "results"


log.info """\
    B L A S T N - P I P E L I N E
    =============================
    blast_db:    ${params.blast_db}
    query_fasta: ${params.query_fasta}
    outdir:      ${params.outdir}
    """
    .stripIndent(true)


process BLASTN {
    cpus 1
    tag "Running apscale_blastn"
    publishDir params.outdir, mode: 'copy'

    input:
    path blast_db
    path query_fasta

    output:
    path '*'

    script:
    """
    apscale_blast blastn -database ${blast_db} -query_fasta ${query_fasta}
    """
}

workflow {
    BLASTN(params.blast_db, params.query_fasta)
}