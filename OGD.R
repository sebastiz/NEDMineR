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
                          replicate(NumRec,sample(paste("Tattoo: ",OGDTattooEnum),1)))
#Multiple
OGDBiopsyType<-paste(replicate(NumRec,paste("Biopsy site:",sample(OGDBiopsyEnum)),1),"Number of biopsies: ",sample(1:8))

OGDDiagnoseType<-paste(replicate(NumRec,paste("Diagnosis:",sample(OGDDiagnosisLookupEnum,2))))
#Multiple
OGDIndicationType<-replicate(NumRec,paste("Indications:",sample(OGDIndicationsEnum,1)))
OGDLimitationType<-replicate(NumRec,paste("Limitations:",sample(OGDLimitationsEnum,1)))

#Multiple for each staff type - and ascribable to each staff type trainer or trainee- will need to be nested
OGDStaffType<-paste(replicate(NumRec,sample(OGDTherapeuticType,1)),
                    replicate(NumRec,paste("Endoscopist Role:",sample(GeneralEndoscopistRoleTypeEnum,1))),
                    replicate(NumRec,paste("Procedure Role:",sample(GeneralProcedureRoleTypeEnum,1))),
                    replicate(NumRec,paste("Extent Type:",sample(OGDExtentTypeEnum,1))))


#The composite:

#Creat columns and then replicate the rows:
OGDProcedureDf <- data.frame(matrix(NA, nrow = 1000, ncol = 1))
OGDProcedureDf$Gender<-replicate(NumRec,paste("Gender: ",sample(GeneralGenderType,1)))
OGDProcedureDf$Age<-replicate(NumRec,paste("Age: ",sample(18:99,1)))
OGDProcedureDf$Admission<-replicate(NumRec,paste("Admission Type: ",sample(GeneralAdmissionTypeEnum,1)))
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
OGDProcedureDf$BiopsyType<-replicate(NumRec,sample(OGDBiopsyType,sample(1:4)))
OGDProcedureDf$AdverseEventType<-replicate(NumRec,sample(AdverseEventType,1))
OGDProcedureDf$DiagnoseType<-replicate(NumRec,sample(OGDDiagnoseType,1))
OGDProcedureDf$Procedure<-replicate(NumRec,sample("Procedure:OGD",1))
OGDProcedureDf$Discomfort<-replicate(NumRec,sample(GeneralDiscomfortEnum[[1]],1))
OGDProcedureDf$Extent<-replicate(NumRec,sample(OGDExtentTypeEnum,1))
OGDProcedureDf$antibioticGiven<-replicate(NumRec,sample(GeneralYesNoEnum,1))
OGDProcedureDf$digitalRectalExamination<-replicate(NumRec,sample(GeneralYesNoEnum,1))
OGDProcedureDf$magneticEndoscopeImagerUsed<-replicate(NumRec,sample(GeneralYesNoEnum,1))
OGDProcedureDf$UKDateType<-replicate(NumRec,paste("Date: ",sample(UKDateType, 1)))
OGDProcedureDf$TimeEnum<-replicate(NumRec,paste("Time: ",sample(TimeEnum,1)))
OGDProcedureDf$GeneralSessionTypeEnum<-replicate(NumRec,paste("Session Type: ",sample(GeneralSessionTypeEnum,1)))


