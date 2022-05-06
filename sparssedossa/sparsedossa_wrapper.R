library("optparse")
library('SparseDOSSA2')
myargs = commandArgs(trailingOnly=TRUE)

ns <- as.numeric(myargs[2])
nf <- as.numeric(myargs[3])





Simulation_Results_List<-SparseDOSSA2(
        template = myargs[1],
        n_sample = ns,
        new_features = TRUE,
        n_feature = nf,
        spike_metadata = "none",
        metadata_effect_size = 1,
        perc_feature_spiked_metadata = 0.05,
        metadata_matrix = NULL,
        median_read_depth = 50000,
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
