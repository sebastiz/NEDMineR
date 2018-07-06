OGDExtentTypeEnum<-ListContstructor("OGDExtentTypeEnum","OGDLimitationsEnum",ProcedureSpecifiValues)
OGDLimitationsEnum<-ListContstructor("OGDLimitationsEnum","OGDIndicationsEnum",ProcedureSpecifiValues)
OGDIndicationsEnum<-ListContstructor("OGDIndicationsEnum","OGDDiagnosisLookupEnum",ProcedureSpecifiValues)
OGDDiagnosisLookupEnum<-ListContstructor("OGDDiagnosisLookupEnum","OGDTherapeuticLookupEnum",ProcedureSpecifiValues)
OGDTherapeuticLookupEnum<-ListContstructor("OGDTherapeuticLookupEnum","OGDBiopsyEnum",ProcedureSpecifiValues)
OGDBiopsyEnum<-ListContstructor("OGDBiopsyEnum","ColonExtentTypeEnum",ProcedureSpecifiValues)
OGDTattooEnum<-ListContstructor("OGDTattooEnum","OGDExtentTypeEnum",ProcedureSpecifiValues)

#Multiple
OGDTherapeuticType<-paste(replicate(NumRec,sample(paste("Therapy: ",OGDTherapeuticLookupEnum),1)),
                          replicate(NumRec,sample(paste("Biopsy: ",OGDBiopsyEnum),1)),
                          replicate(NumRec,sample(paste("PolypSize: ",GeneralPolypSizeEnum),1)),
                          replicate(NumRec,sample(paste("Tattoo: ",OGDTattooEnum),1)),
                          replicate(NumRec,sample(paste("performed: ",OGDTattooEnum),1)),
                          replicate(NumRec,sample(paste("successful: ",OGDTattooEnum),1)),
                          replicate(NumRec,sample(paste("retrieved: ",OGDTattooEnum),1)),
                          replicate(NumRec,"Comment:"))
#Multiple
OGDBiopsyType<-paste(replicate(NumRec,paste("Biopsy site:",sample(OGDBiopsyEnum)),1),"Number of biopsies: ",sample(1:8))

OGDDiagnoseType<-paste(replicate(NumRec,paste("Diagnosis:",sample(OGDDiagnosisLookupEnum,2),"Comment:")))
#Multiple
OGDIndicationType<-replicate(NumRec,paste("Indications:",sample(OGDIndicationsEnum,1),"Comment:"))
OGDLimitationType<-replicate(NumRec,paste("Limitations:",sample(OGDLimitationsEnum,1),"Comment:"))

#Multiple for each staff type - and ascribable to each staff type trainer or trainee- will need to be nested
OGDStaffType<-paste(replicate(NumRec,sample(OGDTherapeuticType,1)),
                    replicate(NumRec,paste("Endoscopist Role:",sample(GeneralEndoscopistRoleTypeEnum,1))),
                    replicate(NumRec,paste("Procedure Role:",sample(GeneralProcedureRoleTypeEnum,1))),
                    replicate(NumRec,paste("professionalBodyCode:",paste0(sample(LETTERS,1),sample(100:110)))),
                    replicate(NumRec,paste("Extent Type:",sample(OGDExtentTypeEnum,1))))


#The composite:

#Creat columns and then replicate the rows:
OGDProcedureDf <- data.frame(matrix(NA, nrow = 1000, ncol = 1))
OGDProcedureDf$Gender<-replicate(NumRec,paste("Gender: ",sample(GeneralGenderType,1)))
OGDProcedureDf$Age<-replicate(NumRec,sample(18:99,1))
OGDProcedureDf$Admission<-replicate(NumRec,paste("Admission Type: ",sample(GeneralAdmissionTypeEnum,1)))
OGDProcedureDf$localProcedureId<-replicate(NumRec,paste0(paste0(sample(LETTERS,1),sample(10000:99999,1,replace=T))))
OGDProcedureDf$PreviouslocalProcedureId<-replicate(NumRec,paste0(paste0(sample(LETTERS,1),sample(10000:99999,1,replace=T))))
OGDProcedureDf$jManoeuvre<-replicate(NumRec,paste("jManoeuvre:",sample(GeneralYesNoEnum,1)))
OGDProcedureDf$Urgency<-replicate(NumRec,paste("Urgency: ",sample(GeneralUrgencyEnum,1)))
OGDProcedureDf$Pethidine<-replicate(NumRec,as.integer(sample(seq(12.5,100,12.5),1)))
OGDProcedureDf$Midazolam<-replicate(NumRec,as.integer(sample(seq(0.5,10,0.5),1)))
OGDProcedureDf$Fentanyl<-replicate(NumRec,as.integer(sample(seq(12.5,100,12.5),1)))
OGDProcedureDf$Buscopan<-replicate(NumRec,as.integer(sample(seq(10,30,10),1)))
OGDProcedureDf$Propofol<-replicate(NumRec,as.integer(sample(seq(12.5,100,12.5),1)))
OGDProcedureDf$entonox<-replicate(NumRec,paste(sample(GeneralYesNoEnum,1)))
OGDProcedureDf$generalAnaes<-replicate(NumRec,paste(sample(GeneralYesNoEnum,1)))
OGDProcedureDf$pharyngealAnaes<-replicate(NumRec,paste(sample(GeneralYesNoEnum,1)))
OGDProcedureDf$NestedProcByRole<-replicate(NumRec,paste(sample(OGDStaffType,sample(1:3))))
OGDProcedureDf$IndicationType<-replicate(NumRec,paste(sample(OGDIndicationType,sample(1:3))))
OGDProcedureDf$LimitationType<-replicate(NumRec,paste(sample(OGDLimitationType,1)))
OGDProcedureDf$Extent<-replicate(NumRec,sample(OGDExtentTypeEnum,1))

######################################################## Local Algo 1########################################################################################
OGDProcedureDf$Extent<-ifelse(grepl("Not Limited|failed", OGDProcedureDf$LimitationType),"D2- 2nd part of duodenum",OGDProcedureDf$Extent)
OGDProcedureDf$ExtentNumber<-ifelse(grepl("Oesophagus", OGDProcedureDf$Extent),1,
                                    ifelse(grepl("Stomach", OGDProcedureDf$Extent),2,
                                           ifelse(grepl("Duodenal bulb", OGDProcedureDf$Extent),3,
                                                  ifelse(grepl("D2", OGDProcedureDf$Extent),4,OGDProcedureDf$Extent))))


##############################################################################################################################################################


#This makes sure that the biopsy site is in a list and that the site is not duplicated
OGDProcedureDf$BiopsyType<-replicate(NumRec,paste(sample(paste("Biopsy site:",sample(OGDBiopsyEnum)),sample(1:4,replace=T))))



########################################################## Local Algo 2 ########################################################################################
#This makes sure that if the biopsy site is none then no number of biopsies are allocated to it.
OGDProcedureDf$BiopsyType<-lapply(OGDProcedureDf$BiopsyType, function(p)
  ifelse(!grepl("None",p),paste(p,"Number of biopsies:",sample(1:10)),p)
)

########################################################## Local Algo 3 ########################################################################################

#Need to make sure the biopsies and extent match up ie the biopsies should only be taken from before the extent

#Checking using the extent has a number. Associate the biopsy site with a number. 
OGDProcedureDf$BiopsyType<-lapply(OGDProcedureDf$BiopsyType, function(p)
  ifelse(grepl("Oesophagus",p),gsub("Biopsy site: Oesophagus","1--Biopsy site: Oesophagus",p),
         ifelse(grepl("Stomach",p),gsub("Biopsy site: Stomach","2--Biopsy site: Stomach",p),
                ifelse(grepl("Duodenal bulb",p),gsub("Biopsy site: Duodenal bulb","3--Biopsy site: Duodenal bulb",p),
                       ifelse(grepl("D2",p),gsub("Biopsy site: D2","4--Biopsy site: D2",p),p)))))


#If the number of extent is < the biopsy site then remove the biopsy site
OGDProcedureDf$BiopsyType<-Map(function(x,y)y[as.numeric(x)>=as.numeric(sub("^(\\d+).*$|.*","\\1",y))],
    OGDProcedureDf$ExtentNumber,OGDProcedureDf$BiopsyType)



########################################################## Local Algo 4 ########################################################################################

# Make sure trainee is doing the same thing as trainer




################################################################################################################################################################


OGDProcedureDf$AdverseEventType<-replicate(NumRec,sample(AdverseEventType,1))
OGDProcedureDf$AdverseEventTypeComment<-replicate(NumRec,"Comment")
OGDProcedureDf$ScopeWithdrawalTime<-replicate(NumRec,paste("Withdrawl time:",sample(3:35,1,replace=T)))
OGDProcedureDf$DiagnoseType<-replicate(NumRec,sample(OGDDiagnoseType,1))
OGDProcedureDf$Procedure<-replicate(NumRec,sample("Procedure:OGD",1))
OGDProcedureDf$Discomfort<-replicate(NumRec,sample(GeneralDiscomfortEnum[[1]],1))
OGDProcedureDf$antibioticGiven<-replicate(NumRec,sample(GeneralYesNoEnum,1))
OGDProcedureDf$digitalRectalExamination<-replicate(NumRec,sample(GeneralYesNoEnum,1))
OGDProcedureDf$magneticEndoscopeImagerUsed<-replicate(NumRec,sample(GeneralYesNoEnum,1))
OGDProcedureDf$UKDateType<-replicate(NumRec,paste("Date: ",sample(UKDateType, 1)))
OGDProcedureDf$TimeEnum<-replicate(NumRec,paste("Time: ",sample(TimeEnum,1)))
OGDProcedureDf$GeneralSessionTypeEnum<-replicate(NumRec,paste("Session Type: ",sample(GeneralSessionTypeEnum,1)))
OGDProcedureDf$GeneralSessionTypeIDEnum<-replicate(NumRec,paste("Session Type: ",paste0(sample(LETTERS,1),sample(10:99,1,replace=T))))
OGDProcedureDf$SessionTypeDescription<-replicate(NumRec,paste("Session Type Description: "))

