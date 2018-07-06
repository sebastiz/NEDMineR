ERCPExtentTypeEnum<-ListContstructor("ERCPExtentTypeEnum","ERCPLimitationsEnum",ProcedureSpecifiValues)
ERCPLimitationsEnum<-ListContstructor("ERCPLimitationsEnum","ERCPIndicationsEnum",ProcedureSpecifiValues)
ERCPIndicationsEnum<-ListContstructor("ERCPIndicationsEnum","ERCPDiagnosisLookupEnum",ProcedureSpecifiValues)
ERCPDiagnosisLookupEnum<-ListContstructor("ERCPDiagnosisLookupEnum","ERCPTherapeuticLookupEnum",ProcedureSpecifiValues)
ERCPTherapeuticLookupEnum<-ListContstructor("ERCPTherapeuticLookupEnum","END",ProcedureSpecifiValues)
ERCPBiopsyEnum<-ListContstructor("ERCPBiopsyEnum","ERCPExtentTypeEnum",ProcedureSpecifiValues)
ERCPTattooEnum<-ListContstructor("ERCPTattooEnum","ERCPBiopsyEnum",ProcedureSpecifiValues)


ERCPTherapeuticType<-paste(replicate(NumRec,sample(paste("Therapy: ",ERCPTherapeuticLookupEnum),1)),
                           replicate(NumRec,sample(paste("Biopsy: ",ERCPBiopsyEnum),1)),
                           replicate(NumRec,sample(paste("PolypSize: ",GeneralPolypSizeEnum),1)),
                           replicate(NumRec,sample(paste("Tattoo: ",ERCPTattooEnum),1)),
                           replicate(NumRec,"Comment:"))

#Multiple
ERCPBiopsyType<-replicate(NumRec,paste("Biopsy site:NA Number of biopsies: NA"))

#Multiple
ERCPDiagnoseType<-paste(replicate(NumRec,paste("Diagnosis:",sample(ERCPDiagnosisLookupEnum,2),"Comment:")))


ERCPIndicationType<-replicate(NumRec,paste("Indications:",sample(ERCPIndicationsEnum,1),"Comment:"))
ERCPLimitationType<-replicate(NumRec,paste("Limitations:",sample(ERCPLimitationsEnum,1),"Comment:"))

#Multiple
ERCPStaffType<-paste(replicate(NumRec,paste(ERCPTherapeuticType,1)),
                     replicate(NumRec,paste("Endoscopist Role:",sample(GeneralEndoscopistRoleTypeEnum,1))),
                     replicate(NumRec,paste("Procedure Role:",sample(GeneralProcedureRoleTypeEnum,1))),
                     replicate(NumRec,paste("Extent Type:",sample(ERCPExtentTypeEnum,1))))

#Composite


#Creat columns and then replicate the rows:
ERCPProcedureDf <- data.frame(matrix(NA, nrow = 1000, ncol = 1))
ERCPProcedureDf$Gender<-replicate(NumRec,paste("Gender: ",sample(GeneralGenderType,1)))
ERCPProcedureDf$Age<-replicate(NumRec,sample(18:99,1))
ERCPProcedureDf$localProcedureId<-replicate(NumRec,paste0(paste0(sample(LETTERS,1),sample(10000:99999,1,replace=T))))
ERCPProcedureDf$PreviouslocalProcedureId<-replicate(NumRec,paste0(paste0(sample(LETTERS,1),sample(10000:99999,1,replace=T))))
ERCPProcedureDf$Admission<-replicate(NumRec,paste("Admission Type: ",sample(GeneralAdmissionTypeEnum,1)))
ERCPProcedureDf$jManoeuvre<-replicate(NumRec,paste("jManoeuvre:",sample(GeneralYesNoEnum,1)))
ERCPProcedureDf$Urgency<-replicate(NumRec,paste("Urgency: ",sample(GeneralUrgencyEnum,1)))
ERCPProcedureDf$Pethidine<-replicate(NumRec,as.integer(sample(seq(12.5,100,12.5),1)))
ERCPProcedureDf$Midazolam<-replicate(NumRec,as.integer(sample(seq(0.5,10,0.5),1)))
ERCPProcedureDf$Fentanyl<-replicate(NumRec,as.integer(sample(seq(12.5,100,12.5),1)))
ERCPProcedureDf$Buscopan<-replicate(NumRec,as.integer(sample(seq(10,30,10),1)))
ERCPProcedureDf$Propofol<-replicate(NumRec,as.integer(sample(seq(12.5,100,12.5),1)))
ERCPProcedureDf$entonox<-replicate(NumRec,paste(sample(GeneralYesNoEnum,1)))
ERCPProcedureDf$generalAnaes<-replicate(NumRec,paste(sample(GeneralYesNoEnum,1)))
ERCPProcedureDf$pharyngealAnaes<-replicate(NumRec,paste(sample(GeneralYesNoEnum,1)))
ERCPProcedureDf$NestedProcByRole<-replicate(NumRec,paste(sample(ERCPStaffType,sample(1:3))))
ERCPProcedureDf$IndicationType<-replicate(NumRec,paste(sample(ERCPIndicationType,sample(1:3))))
ERCPProcedureDf$LimitationType<-replicate(NumRec,paste(sample(ERCPLimitationType,1)))
#ERCPProcedureDf$BiopsyType<-replicate(NumRec,sample(ERCPBiopsyType,1))
ERCPProcedureDf$Extent<-replicate(NumRec,sample(ERCPExtentTypeEnum,1))

######################################################## Local Algo 1########################################################################################
ERCPProcedureDf$Extent<-ifelse(grepl("Not Limited|failed", ERCPProcedureDf$LimitationType),"D2- 2nd part of duodenum",ERCPProcedureDf$Extent)
ERCPProcedureDf$ExtentNumber<-ifelse(grepl("Oesophagus", ERCPProcedureDf$Extent),1,
                                    ifelse(grepl("Stomach", ERCPProcedureDf$Extent),2,
                                           ifelse(grepl("Duodenal bulb", ERCPProcedureDf$Extent),3,
                                                  ifelse(grepl("D2", ERCPProcedureDf$Extent),4,ERCPProcedureDf$Extent))))


##############################################################################################################################################################


#This makes sure that the biopsy site is in a list and that the site is not duplicated
ERCPProcedureDf$BiopsyType<-replicate(NumRec,paste(sample(paste("Biopsy site:",sample(ERCPBiopsyEnum,replace=T)),sample(1:4,replace=T),replace=T)))



########################################################## Local Algo 2 ########################################################################################
#This makes sure that if the biopsy site is none then no number of biopsies are allocated to it.
ERCPProcedureDf$BiopsyType<-lapply(ERCPProcedureDf$BiopsyType, function(p)
  ifelse(!grepl("None",p),paste(p,"Number of biopsies:",sample(1:10)),p)
)

########################################################## Local Algo 3 ########################################################################################

#Need to make sure the biopsies and extent match up ie the biopsies should only be taken from before the extent

#Checking using the extent has a number. Associate the biopsy site with a number. 
ERCPProcedureDf$BiopsyType<-lapply(ERCPProcedureDf$BiopsyType, function(p)
  ifelse(grepl("Oesophagus",p),gsub("Biopsy site: Oesophagus","1--Biopsy site: Oesophagus",p),
         ifelse(grepl("Stomach",p),gsub("Biopsy site: Stomach","2--Biopsy site: Stomach",p),
                ifelse(grepl("Duodenal bulb",p),gsub("Biopsy site: Duodenal bulb","3--Biopsy site: Duodenal bulb",p),
                       ifelse(grepl("D2",p),gsub("Biopsy site: D2","4--Biopsy site: D2",p),p)))))


#If the number of extent is < the biopsy site then remove the biopsy site
ERCPProcedureDf$BiopsyType<-Map(function(x,y)y[as.numeric(x)>=as.numeric(sub("^(\\d+).*$|.*","\\1",y))],
                               ERCPProcedureDf$ExtentNumber,ERCPProcedureDf$BiopsyType)



########################################################## Local Algo 4 ########################################################################################

# Make sure trainee is doing the same thing as trainer:


################################################################################################################################################################


ERCPProcedureDf$AdverseEventType<-replicate(NumRec,sample(AdverseEventType,1))
ERCPProcedureDf$AdverseEventTypeComment<-replicate(NumRec,"Comment")
ERCPProcedureDf$ScopeWithdrawalTime<-replicate(NumRec,paste("Withdrawl time:",sample(3:35,1,replace=T)))
ERCPProcedureDf$DiagnoseType<-replicate(NumRec,sample(ERCPDiagnoseType,1))
ERCPProcedureDf$Procedure<-replicate(NumRec,sample("Procedure:ERCP",1))
ERCPProcedureDf$Discomfort<-replicate(NumRec,sample(GeneralDiscomfortEnum[[1]],1))
ERCPProcedureDf$antibioticGiven<-replicate(NumRec,sample(GeneralYesNoEnum,1))
ERCPProcedureDf$digitalRectalExamination<-replicate(NumRec,sample(GeneralYesNoEnum,1))
ERCPProcedureDf$magneticEndoscopeImagerUsed<-replicate(NumRec,sample(GeneralYesNoEnum,1))
ERCPProcedureDf$UKDateType<-replicate(NumRec,paste("Date: ",sample(UKDateType, 1)))
ERCPProcedureDf$TimeEnum<-replicate(NumRec,paste("Time: ",sample(TimeEnum,1)))
ERCPProcedureDf$GeneralSessionTypeEnum<-replicate(NumRec,paste("Session Type: ",sample(GeneralSessionTypeEnum,1)))
ERCPProcedureDf$GeneralSessionTypeIDEnum<-replicate(NumRec,paste("Session Type: ",paste0(sample(LETTERS,1),sample(10:99,1,replace=T))))
ERCPProcedureDf$SessionTypeDescription<-replicate(NumRec,paste("Session Type Description: "))

