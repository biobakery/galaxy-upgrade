library("optparse")
library('SparseDOSSA2')
myargs = commandArgs(trailingOnly=TRUE)

p_template <- myargs[1]
p_ns <- as.numeric(myargs[2])
p_nf <- as.numeric(myargs[3])
p_metadata_effect_size <-  as.numeric(myargs[4])
p_perc_feature_spiked_metadata <- as.double(myargs[5])
p_median_read_depth <- as.numeric(myargs[6])
p_spike_metadata <- myargs[7]


Simulation_Results_List<-SparseDOSSA2(
        template = p_template,
        n_sample = p_ns,
        new_features = TRUE,
        n_feature = p_nf,
        spike_metadata = p_spike_metadata,
        metadata_effect_size = p_metadata_effect_size,
        perc_feature_spiked_metadata = p_perc_feature_spiked_metadata,
        metadata_matrix = NULL,
        median_read_depth = p_median_read_depth,
        verbose = TRUE
      )


lNames <- names(Simulation_Results_List)

for(i in 1:2) {
    df  <- as.data.frame(Simulation_Results_List[i])
    Output_FileName <- paste(lNames[i],"csv",sep=".")
    Output_FileName <- paste(Output_FileName,sep="")
    write.csv(df ,Output_FileName)
                }
Simulation_Results_FileName <- paste("Simulation.RData",sep="")

save(Simulation_Results_List,file=Simulation_Results_FileName)

if (p_spike_metadata != "none")
{
  out1 <- as.data.frame(Simulation_Results_List$spike_metadata$metadata_matrix)
  write.csv(out1,"simulated_metadata.csv", row.names = FALSE)

  out2 <- as.data.frame(Simulation_Results_List$spike_metadata$feature_metadata_spike_df)
  write.csv(out2,"microbiome_metadata_association.csv", row.names = FALSE)
}


