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
                           replicate(NumRec,sample(paste("Tattoo: ",ERCPTattooEnum),1)))

#Multiple
ERCPBiopsyType<-replicate(NumRec,paste("Biopsy site:NA Number of biopsies: NA"))

#Multiple
ERCPDiagnoseType<-paste(replicate(NumRec,paste("Diagnosis:",sample(ERCPDiagnosisLookupEnum,1))))


ERCPIndicationType<-replicate(NumRec,paste("Indications:",sample(ERCPIndicationsEnum,1)))
ERCPLimitationType<-replicate(NumRec,paste("Limitations:",sample(ERCPLimitationsEnum,1)))

#Multiple
ERCPStaffType<-paste(replicate(NumRec,paste(ERCPTherapeuticType,1)),
                     replicate(NumRec,paste("Endoscopist Role:",sample(GeneralEndoscopistRoleTypeEnum,1))),
                     replicate(NumRec,paste("Procedure Role:",sample(GeneralProcedureRoleTypeEnum,1))),
                     replicate(NumRec,paste("Extent Type:",sample(ERCPExtentTypeEnum,1))),
                     replicate(NumRec,paste("jManoeuvre:",sample(GeneralYesNoEnum,1))))


#Composite


#Creat columns and then replicate the rows:
ERCPProcedureDf <- data.frame(matrix(NA, nrow = 1000, ncol = 1))
ERCPProcedureDf$Gender<-replicate(NumRec,paste("Gender: ",sample(GeneralGenderType,1)))
ERCPProcedureDf$Age<-replicate(NumRec,paste("Age: ",sample(18:99,1)))
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
ERCPProcedureDf$BiopsyType<-replicate(NumRec,sample(ERCPBiopsyType,1))
ERCPProcedureDf$AdverseEventType<-replicate(NumRec,sample(AdverseEventType,1))
ERCPProcedureDf$DiagnoseType<-replicate(NumRec,sample(ERCPDiagnoseType,1))
ERCPProcedureDf$Procedure<-replicate(NumRec,sample("Procedure:ERCP",1))
ERCPProcedureDf$Discomfort<-replicate(NumRec,sample(GeneralDiscomfortEnum[[1]],1))
ERCPProcedureDf$Extent<-replicate(NumRec,sample(ERCPExtentTypeEnum,1))
ERCPProcedureDf$antibioticGiven<-replicate(NumRec,sample(GeneralYesNoEnum,1))
ERCPProcedureDf$digitalRectalExamination<-replicate(NumRec,sample(GeneralYesNoEnum,1))
ERCPProcedureDf$magneticEndoscopeImagerUsed<-replicate(NumRec,sample(GeneralYesNoEnum,1))
ERCPProcedureDf$UKDateType<-replicate(NumRec,paste("Date: ",sample(UKDateType, 1)))
ERCPProcedureDf$TimeEnum<-replicate(NumRec,paste("Time: ",sample(TimeEnum,1)))
ERCPProcedureDf$GeneralSessionTypeEnum<-replicate(NumRec,paste("Session Type: ",sample(GeneralSessionTypeEnum,1)))

