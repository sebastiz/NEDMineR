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
                            replicate(NumRec,sample(paste("Tattoo: ",ColonTattooEnum),1)))

ColonBiopsyType<-paste(replicate(NumRec,paste("Biopsy site:",sample(ColonBiopsyEnum)),1),"Number of biopsies: ",sample(1:8))

ColonDiagnoseType<-paste(replicate(NumRec,paste("Diagnosis:",sample(ColonDiagnosisLookupEnum,1))))

ColonIndicationType<-replicate(NumRec,paste("Indications:",sample(ColonIndicationsEnum,1)))
ColonLimitationType<-replicate(NumRec,paste("Limitations:",sample(ColonLimitationsEnum,1)))

ColonStaffType<-paste(replicate(NumRec,paste(ColonTherapeuticType,1)),
                      replicate(NumRec,paste("Endoscopist Role:",sample(GeneralEndoscopistRoleTypeEnum[[1]],1))),
                      replicate(NumRec,paste("Procedure Role:",sample(GeneralProcedureRoleTypeEnum[[1]],1))),
                      replicate(NumRec,paste("Extent Type:",sample(ColonExtentTypeEnum,1))),
                      replicate(NumRec,paste("jManoeuvre:",sample(GeneralYesNoEnum,1))))


#Composite

#Creat columns and then replicate the rows:
ColonProcedureDf <- data.frame(matrix(NA, nrow = 1000, ncol = 1))
ColonProcedureDf$Gender<-replicate(NumRec,paste("Gender: ",sample(GeneralGenderType,1)))
ColonProcedureDf$Age<-replicate(NumRec,paste("Age: ",sample(18:99,1)))
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
ColonProcedureDf$BiopsyType<-replicate(NumRec,sample(ColonBiopsyType,1))
ColonProcedureDf$AdverseEventType<-replicate(NumRec,sample(AdverseEventType,1))
ColonProcedureDf$DiagnoseType<-replicate(NumRec,sample(ColonDiagnoseType,1))
ColonProcedureDf$Procedure<-replicate(NumRec,sample("Procedure:Colon",1))
ColonProcedureDf$Discomfort<-replicate(NumRec,sample(GeneralDiscomfortEnum[[1]],1))
ColonProcedureDf$Extent<-replicate(NumRec,sample(ColonExtentTypeEnum,1))
ColonProcedureDf$antibioticGiven<-replicate(NumRec,sample(GeneralYesNoEnum,1))
ColonProcedureDf$digitalRectalExamination<-replicate(NumRec,sample(GeneralYesNoEnum,1))
ColonProcedureDf$magneticEndoscopeImagerUsed<-replicate(NumRec,sample(GeneralYesNoEnum,1))
ColonProcedureDf$UKDateType<-replicate(NumRec,paste("Date: ",sample(UKDateType, 1)))
ColonProcedureDf$TimeEnum<-replicate(NumRec,paste("Time: ",sample(TimeEnum,1)))
ColonProcedureDf$GeneralSessionTypeEnum<-replicate(NumRec,paste("Session Type: ",sample(GeneralSessionTypeEnum,1)))


