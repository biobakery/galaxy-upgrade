library("optparse")
library('SparseDOSSA2')
option_list = list(
    make_option(c("-t", "--template"), action="store", default="Stool", type='character',
              help="Template name"),
    make_option(c("-s", "--n_sample"), type = "integer", default = 100,
            help = "Number of samples [default %default]",
            metavar = "number"),
    make_option(c("-f", "--n_feature"), type = "integer", default = 100,
            help = "Number of features [default %default]",
            metavar = "number")
)

opt = parse_args(OptionParser(option_list=option_list))


Simulation_Results_List  <- SparseDOSSA2(template = opt$template,
                                 n_sample = opt$n_sample,
                                 n_feature = opt$n_feature,
                                 verbose = TRUE)

lNames <- names(Simulation_Results_List)

for(i in 1:2) {
    df  <- as.data.frame(Simulation_Results_List[i])
    Output_FileName <- paste(lNames[i],"csv",sep=".")
    Output_FileName <- paste(Output_FileName,sep="")
    write.csv(df ,Output_FileName)
                }
Simulation_Results_FileName <- paste(Simulation.RData",sep="")

save(Simulation_Results_List,file=Simulation_Results_FileName)