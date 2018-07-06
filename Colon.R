ColonExtentTypeEnum<-ListContstructor("ColonExtentTypeEnum","ColonLimitationsEnum",ProcedureSpecifiValues)
ColonLimitationsEnum<-ListContstructor("ColonLimitationsEnum","ColonIndicationsEnum",ProcedureSpecifiValues)
ColonIndicationsEnum<-ListContstructor("ColonIndicationsEnum","ColonDiagnosisLookupEnum",ProcedureSpecifiValues)
ColonDiagnosisLookupEnum<-ListContstructor("ColonDiagnosisLookupEnum","ColonTherapeuticLookupEnum",ProcedureSpecifiValues)
ColonTherapeuticLookupEnum<-ListContstructor("ColonTherapeuticLookupEnum","ColonBiopsyEnum",ProcedureSpecifiValues)
ColonBiopsyEnum<-ListContstructor("ColonBiopsyEnum","ColonBowelPrepEnum",ProcedureSpecifiValues)
ColonBowelPrepEnum<-ListContstructor("ColonBowelPrepEnum","ColonTattooEnum",ProcedureSpecifiValues)
ColonTattooEnum<-ListContstructor("ColonTattooEnum","FlexiExtentTypeEnum",ProcedureSpecifiValues)

ColonTherapeuticType<-paste(replicate(NumRec,sample(paste("Therapy: ",ColonTherapeuticLookupEnum),1)),
                            replicate(NumRec,sample(paste("Biopsy: ",ColonBiopsyEnum),1)),
                            replicate(NumRec,sample(paste("PolypSize: ",GeneralPolypSizeEnum[[1]]),1)),
                            replicate(NumRec,sample(paste("Tattoo: ",ColonTattooEnum),1)),
                            replicate(NumRec,"Comment:"))


ColonBiopsyType<-paste(replicate(NumRec,paste("Biopsy site:",sample(ColonBiopsyEnum)),1),"Number of biopsies: ",sample(1:8))

ColonDiagnoseType<-paste(replicate(NumRec,paste("Diagnosis:",sample(ColonDiagnosisLookupEnum,1),"Comment:")))

ColonIndicationType<-replicate(NumRec,paste("Indications:",sample(ColonIndicationsEnum,1),"Comment:"))
ColonLimitationType<-replicate(NumRec,paste("Limitations:",sample(ColonLimitationsEnum,1),"Comment:"))

ColonStaffType<-paste(replicate(NumRec,paste(ColonTherapeuticType,1)),
                      replicate(NumRec,paste("Endoscopist Role:",sample(GeneralEndoscopistRoleTypeEnum[[1]],1))),
                      replicate(NumRec,paste("Procedure Role:",sample(GeneralProcedureRoleTypeEnum[[1]],1))),
                      replicate(NumRec,paste("Extent Type:",sample(ColonExtentTypeEnum,1))),
                      replicate(NumRec,paste("jManoeuvre:",sample(GeneralYesNoEnum,1))))


#Composite

#Creat columns and then replicate the rows:
ColonProcedureDf <- data.frame(matrix(NA, nrow = 1000, ncol = 1))
ColonProcedureDf$Gender<-replicate(NumRec,paste("Gender: ",sample(GeneralGenderType,1)))
ColonProcedureDf$Age<-replicate(NumRec,sample(18:99,1))
ColonProcedureDf$localProcedureId<-replicate(NumRec,paste0(paste0(sample(LETTERS,1),sample(10000:99999,1,replace=T))))
ColonProcedureDf$PreviouslocalProcedureId<-replicate(NumRec,paste0(paste0(sample(LETTERS,1),sample(10000:99999,1,replace=T))))
ColonProcedureDf$Admission<-replicate(NumRec,paste("Admission Type: ",sample(GeneralAdmissionTypeEnum,1)))
ColonProcedureDf$jManoeuvre<-replicate(NumRec,paste("jManoeuvre:",sample(GeneralYesNoEnum,1)))
ColonProcedureDf$Urgency<-replicate(NumRec,paste("Urgency: ",sample(GeneralUrgencyEnum,1)))
ColonProcedureDf$Pethidine<-replicate(NumRec,as.integer(sample(seq(12.5,100,12.5),1)))
ColonProcedureDf$Midazolam<-replicate(NumRec,as.integer(sample(seq(0.5,10,0.5),1)))
ColonProcedureDf$Fentanyl<-replicate(NumRec,as.integer(sample(seq(12.5,100,12.5),1)))
ColonProcedureDf$Buscopan<-replicate(NumRec,as.integer(sample(seq(10,30,10),1)))
ColonProcedureDf$Propofol<-replicate(NumRec,as.integer(sample(seq(12.5,100,12.5),1)))
ColonProcedureDf$entonox<-replicate(NumRec,paste(sample(GeneralYesNoEnum,1)))
ColonProcedureDf$generalAnaes<-replicate(NumRec,paste(sample(GeneralYesNoEnum,1)))
ColonProcedureDf$pharyngealAnaes<-replicate(NumRec,paste(sample(GeneralYesNoEnum,1)))
ColonProcedureDf$NestedProcByRole<-replicate(NumRec,paste(sample(ColonStaffType,sample(1:3))))
ColonProcedureDf$IndicationType<-replicate(NumRec,paste(sample(ColonIndicationType,sample(1:3))))
ColonProcedureDf$LimitationType<-replicate(NumRec,paste(sample(ColonLimitationType,1)))
#ColonProcedureDf$BiopsyType<-replicate(NumRec,sample(ColonBiopsyType,1))
ColonProcedureDf$Extent<-replicate(NumRec,sample(ColonExtentTypeEnum,1))

######################################################## Local Algo 1########################################################################################
ColonProcedureDf$Extent<-ifelse(grepl("Not Limited|failed", ColonProcedureDf$LimitationType),"D2- 2nd part of duodenum",ColonProcedureDf$Extent)
ColonProcedureDf$ExtentNumber<-ifelse(grepl("Anus", ColonProcedureDf$Extent),1,
                                    ifelse(grepl("Pouch", ColonProcedureDf$Extent),2,
                                    ifelse(grepl("Rectum", ColonProcedureDf$Extent),3,
                                    ifelse(grepl("Sigmoid colon", ColonProcedureDf$Extent),4,
                                    ifelse(grepl("Descending Colon", ColonProcedureDf$Extent),5,
                                    ifelse(grepl("Splenic flexure", ColonProcedureDf$Extent),6,
                                    ifelse(grepl("Transverse Colon", ColonProcedureDf$Extent),7,
                                    ifelse(grepl("Hepatic flexure", ColonProcedureDf$Extent),8,
                                    ifelse(grepl("Ascending Colon", ColonProcedureDf$Extent),9,
                                    ifelse(grepl("Caecum", ColonProcedureDf$Extent),10,
                                    ifelse(grepl("Ascending Colon", ColonProcedureDf$Extent),11,
                                    ifelse(grepl("Ileo-colon anastomosis", ColonProcedureDf$Extent),12,
                                    ifelse(grepl("Terminal ileum", ColonProcedureDf$Extent),13,
                                    ifelse(grepl("Neo-terminal ileum", ColonProcedureDf$Extent),14,
                                    ifelse(grepl("Neo-terminal ileum", ColonProcedureDf$Extent),15,
                                    ifelse(grepl("Caecum", ColonProcedureDf$Extent),3,ColonProcedureDf$Extent))))))))))))))))


##############################################################################################################################################################


#This makes sure that the biopsy site is in a list and that the site is not duplicated
ColonProcedureDf$BiopsyType<-replicate(NumRec,paste(sample(paste("Biopsy site:",sample(ColonBiopsyEnum)),sample(1:4,replace=T))))



########################################################## Local Algo 2 ########################################################################################
#This makes sure that if the biopsy site is none then no number of biopsies are allocated to it.
ColonProcedureDf$BiopsyType<-lapply(ColonProcedureDf$BiopsyType, function(p)
  ifelse(!grepl("None",p),paste(p,"Number of biopsies:",sample(1:10)),p)
)

########################################################## Local Algo 3 ########################################################################################

#Need to make sure the biopsies and extent match up ie the biopsies should only be taken from before the extent

#Checking using the extent has a number. Associate the biopsy site with a number. 
ColonProcedureDf$BiopsyType<-lapply(ColonProcedureDf$BiopsyType, function(p)
  ifelse(grepl("Oesophagus",p),gsub("Biopsy site: Oesophagus","1--Biopsy site: Oesophagus",p),
         ifelse(grepl("Stomach",p),gsub("Biopsy site: Stomach","2--Biopsy site: Stomach",p),
                ifelse(grepl("Duodenal bulb",p),gsub("Biopsy site: Duodenal bulb","3--Biopsy site: Duodenal bulb",p),
                       ifelse(grepl("D2",p),gsub("Biopsy site: D2","4--Biopsy site: D2",p),p)))))


#If the number of extent is < the biopsy site then remove the biopsy site
ColonProcedureDf$BiopsyType<-Map(function(x,y)y[as.numeric(x)>=as.numeric(sub("^(\\d+).*$|.*","\\1",y))],
                               ColonProcedureDf$ExtentNumber,ColonProcedureDf$BiopsyType)



########################################################## Local Algo 4 ########################################################################################

# Make sure trainee is doing the same thing as trainer




################################################################################################################################################################

ColonProcedureDf$AdverseEventType<-replicate(NumRec,sample(AdverseEventType,1))
ColonProcedureDf$AdverseEventTypeComment<-replicate(NumRec,"Comment")
ColonProcedureDf$ScopeWithdrawalTime<-replicate(NumRec,paste("Withdrawl time:",sample(3:35,1,replace=T)))
ColonProcedureDf$DiagnoseType<-replicate(NumRec,sample(ColonDiagnoseType,1))
ColonProcedureDf$Procedure<-replicate(NumRec,sample("Procedure:Colon",1))
ColonProcedureDf$Discomfort<-replicate(NumRec,sample(GeneralDiscomfortEnum[[1]],1))
ColonProcedureDf$antibioticGiven<-replicate(NumRec,sample(GeneralYesNoEnum,1))
ColonProcedureDf$digitalRectalExamination<-replicate(NumRec,sample(GeneralYesNoEnum,1))
ColonProcedureDf$magneticEndoscopeImagerUsed<-replicate(NumRec,sample(GeneralYesNoEnum,1))
ColonProcedureDf$UKDateType<-replicate(NumRec,paste("Date: ",sample(UKDateType, 1)))
ColonProcedureDf$TimeEnum<-replicate(NumRec,paste("Time: ",sample(TimeEnum,1)))
ColonProcedureDf$GeneralSessionTypeEnum<-replicate(NumRec,paste("Session Type: ",sample(GeneralSessionTypeEnum,1)))
ColonProcedureDf$GeneralSessionTypeIDEnum<-replicate(NumRec,paste("Session Type: ",paste0(sample(LETTERS,1),sample(10:99,1,replace=T))))

ColonProcedureDf$SessionTypeDescription<-replicate(NumRec,paste("Session Type Description: "))
