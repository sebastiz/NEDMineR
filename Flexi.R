FlexiExtentTypeEnum<-ListContstructor("FlexiExtentTypeEnum","FlexiLimitationsEnum",ProcedureSpecifiValues)
FlexiLimitationsEnum<-ListContstructor("FlexiLimitationsEnum","FlexiIndicationsEnum",ProcedureSpecifiValues)
FlexiIndicationsEnum<-ListContstructor("FlexiIndicationsEnum","FlexiDiagnosisLookupEnum",ProcedureSpecifiValues)
FlexiDiagnosisLookupEnum<-ListContstructor("FlexiDiagnosisLookupEnum","FlexiTherapeuticLookupEnum",ProcedureSpecifiValues)
FlexiTherapeuticLookupEnum<-ListContstructor("FlexiTherapeuticLookupEnum","FlexiBiopsyEnum",ProcedureSpecifiValues)
FlexiBiopsyEnum<-ListContstructor("FlexiBiopsyEnum","FlexiBowelPrepEnum",ProcedureSpecifiValues)
FlexiBowelPrepEnum<-ListContstructor("FlexiBowelPrepEnum","FlexiTattooEnum",ProcedureSpecifiValues)
FlexiTattooEnum<-ListContstructor("FlexiTattooEnum","ERCPTattooEnum",ProcedureSpecifiValues)

#Multiple
FlexiTherapeuticType<-paste(replicate(NumRec,sample(paste("Therapy: ",FlexiTherapeuticLookupEnum),1)),
                            replicate(NumRec,sample(paste("Biopsy: ",FlexiBiopsyEnum),1)),
                            replicate(NumRec,sample(paste("PolypSize: ",GeneralPolypSizeEnum[[1]]),1)),
                            replicate(NumRec,sample(paste("Tattoo: ",FlexiTattooEnum),1)))

#Multiple
FlexiBiopsyType<-paste(replicate(NumRec,paste("Biopsy site:",sample(FlexiBiopsyEnum[[1]])),1),"Number of biopsies: ",sample(1:8))

FlexiDiagnoseType<-paste(replicate(NumRec,paste("Diagnosis:",sample(FlexiDiagnosisLookupEnum,1))))

#Multiple
FlexiIndicationType<-replicate(NumRec,paste("Indications:",sample(FlexiIndicationsEnum,1)))
FlexiLimitationType<-replicate(NumRec,paste("Limitations:",sample(FlexiLimitationsEnum,1)))

FlexiStaffType<-paste(replicate(NumRec,paste(FlexiTherapeuticType,1)),
                      replicate(NumRec,paste("Endoscopist Role:",sample(GeneralEndoscopistRoleTypeEnum[[1]],1))),
                      replicate(NumRec,paste("Procedure Role:",sample(GeneralProcedureRoleTypeEnum[[1]],1))),
                      replicate(NumRec,paste("Extent Type:",sample(FlexiExtentTypeEnum,1))))


#Composite

#Creat columns and then replicate the rows:
FlexiProcedureDf <- data.frame(matrix(NA, nrow = 1000, ncol = 1))
FlexiProcedureDf$Gender<-replicate(NumRec,paste("Gender: ",sample(GeneralGenderType,1)))
FlexiProcedureDf$Age<-replicate(NumRec,paste("Age: ",sample(18:99,1)))
FlexiProcedureDf$Admission<-replicate(NumRec,paste("Admission Type: ",sample(GeneralAdmissionTypeEnum,1)))
FlexiProcedureDf$jManoeuvre<-replicate(NumRec,paste("jManoeuvre:",sample(GeneralYesNoEnum,1)))
FlexiProcedureDf$Urgency<-replicate(NumRec,paste("Urgency: ",sample(GeneralUrgencyEnum,1)))
FlexiProcedureDf$Pethidine<-replicate(NumRec,as.integer(sample(seq(12.5,100,12.5),1)))
FlexiProcedureDf$Midazolam<-replicate(NumRec,as.integer(sample(seq(0.5,10,0.5),1)))
FlexiProcedureDf$Fentanyl<-replicate(NumRec,as.integer(sample(seq(12.5,100,12.5),1)))
FlexiProcedureDf$Buscopan<-replicate(NumRec,as.integer(sample(seq(10,30,10),1)))
FlexiProcedureDf$Propofol<-replicate(NumRec,as.integer(sample(seq(12.5,100,12.5),1)))
FlexiProcedureDf$entonox<-replicate(NumRec,paste(sample(GeneralYesNoEnum,1)))
FlexiProcedureDf$generalAnaes<-replicate(NumRec,paste(sample(GeneralYesNoEnum,1)))
FlexiProcedureDf$pharyngealAnaes<-replicate(NumRec,paste(sample(GeneralYesNoEnum,1)))
FlexiProcedureDf$NestedProcByRole<-replicate(NumRec,paste(sample(FlexiStaffType,sample(1:3))))
FlexiProcedureDf$IndicationType<-replicate(NumRec,paste(sample(FlexiIndicationType,sample(1:3))))
FlexiProcedureDf$LimitationType<-replicate(NumRec,paste(sample(FlexiLimitationType,1)))
#FlexiProcedureDf$BiopsyType<-replicate(NumRec,sample(FlexiBiopsyType,1))
FlexiProcedureDf$Extent<-replicate(NumRec,sample(FlexiExtentTypeEnum,1))


######################################################## Local Algo 1########################################################################################
FlexiProcedureDf$Extent<-ifelse(grepl("Not Limited|failed", FlexiProcedureDf$LimitationType),"D2- 2nd part of duodenum",FlexiProcedureDf$Extent)
FlexiProcedureDf$ExtentNumber<-ifelse(grepl("Oesophagus", FlexiProcedureDf$Extent),1,
                                    ifelse(grepl("Stomach", FlexiProcedureDf$Extent),2,
                                           ifelse(grepl("Duodenal bulb", FlexiProcedureDf$Extent),3,
                                                  ifelse(grepl("D2", FlexiProcedureDf$Extent),4,FlexiProcedureDf$Extent))))


##############################################################################################################################################################


#This makes sure that the biopsy site is in a list and that the site is not duplicated
FlexiProcedureDf$BiopsyType<-replicate(NumRec,paste(sample(paste("Biopsy site:",sample(FlexiBiopsyEnum)),sample(1:4,replace=T))))



########################################################## Local Algo 2 ########################################################################################
#This makes sure that if the biopsy site is none then no number of biopsies are allocated to it.
FlexiProcedureDf$BiopsyType<-lapply(FlexiProcedureDf$BiopsyType, function(p)
  ifelse(!grepl("None",p),paste(p,"Number of biopsies:",sample(1:10)),p)
)

########################################################## Local Algo 3 ########################################################################################

#Need to make sure the biopsies and extent match up ie the biopsies should only be taken from before the extent

#Checking using the extent has a number. Associate the biopsy site with a number. 
FlexiProcedureDf$BiopsyType<-lapply(FlexiProcedureDf$BiopsyType, function(p)
  ifelse(grepl("Oesophagus",p),gsub("Biopsy site: Oesophagus","1--Biopsy site: Oesophagus",p),
         ifelse(grepl("Stomach",p),gsub("Biopsy site: Stomach","2--Biopsy site: Stomach",p),
                ifelse(grepl("Duodenal bulb",p),gsub("Biopsy site: Duodenal bulb","3--Biopsy site: Duodenal bulb",p),
                       ifelse(grepl("D2",p),gsub("Biopsy site: D2","4--Biopsy site: D2",p),p)))))


#If the number of extent is < the biopsy site then remove the biopsy site
FlexiProcedureDf$BiopsyType<-Map(function(x,y)y[as.numeric(x)>=as.numeric(sub("^(\\d+).*$|.*","\\1",y))],
                               FlexiProcedureDf$ExtentNumber,FlexiProcedureDf$BiopsyType)



########################################################## Local Algo 4 ########################################################################################

# Make sure trainee is doing the same thing as trainer





################################################################################################################################################################
FlexiProcedureDf$AdverseEventType<-replicate(NumRec,sample(AdverseEventType,1))
FlexiProcedureDf$DiagnoseType<-replicate(NumRec,sample(FlexiDiagnoseType,1))
FlexiProcedureDf$Procedure<-replicate(NumRec,sample("Procedure:Flexi",1))
FlexiProcedureDf$Discomfort<-replicate(NumRec,sample(GeneralDiscomfortEnum[[1]],1))
FlexiProcedureDf$antibioticGiven<-replicate(NumRec,sample(GeneralYesNoEnum,1))
FlexiProcedureDf$digitalRectalExamination<-replicate(NumRec,sample(GeneralYesNoEnum,1))
FlexiProcedureDf$magneticEndoscopeImagerUsed<-replicate(NumRec,sample(GeneralYesNoEnum,1))
FlexiProcedureDf$UKDateType<-replicate(NumRec,paste("Date: ",sample(UKDateType, 1)))
FlexiProcedureDf$TimeEnum<-replicate(NumRec,paste("Time: ",sample(TimeEnum,1)))
FlexiProcedureDf$GeneralSessionTypeEnum<-replicate(NumRec,paste("Session Type: ",sample(GeneralSessionTypeEnum,1)))