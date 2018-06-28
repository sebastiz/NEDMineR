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
                      replicate(NumRec,paste("Extent Type:",sample(FlexiExtentTypeEnum,1))),
                      replicate(NumRec,paste("jManoeuvre:",sample(GeneralYesNoEnum,1))))


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
FlexiProcedureDf$BiopsyType<-replicate(NumRec,sample(FlexiBiopsyType,1))
FlexiProcedureDf$AdverseEventType<-replicate(NumRec,sample(AdverseEventType,1))
FlexiProcedureDf$DiagnoseType<-replicate(NumRec,sample(FlexiDiagnoseType,1))
FlexiProcedureDf$Procedure<-replicate(NumRec,sample("Procedure:Flexi",1))
FlexiProcedureDf$Discomfort<-replicate(NumRec,sample(GeneralDiscomfortEnum[[1]],1))
FlexiProcedureDf$Extent<-replicate(NumRec,sample(FlexiExtentTypeEnum,1))
FlexiProcedureDf$antibioticGiven<-replicate(NumRec,sample(GeneralYesNoEnum,1))
FlexiProcedureDf$digitalRectalExamination<-replicate(NumRec,sample(GeneralYesNoEnum,1))
FlexiProcedureDf$magneticEndoscopeImagerUsed<-replicate(NumRec,sample(GeneralYesNoEnum,1))
FlexiProcedureDf$UKDateType<-replicate(NumRec,paste("Date: ",sample(UKDateType, 1)))
FlexiProcedureDf$TimeEnum<-replicate(NumRec,paste("Time: ",sample(TimeEnum,1)))
FlexiProcedureDf$GeneralSessionTypeEnum<-replicate(NumRec,paste("Session Type: ",sample(GeneralSessionTypeEnum,1)))