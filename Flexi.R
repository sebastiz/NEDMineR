FlexiExtentTypeEnum<-ListContstructor("FlexiExtentTypeEnum","FlexiLimitationsEnum",ProcedureSpecifiValues)
FlexiLimitationsEnum<-ListContstructor("FlexiLimitationsEnum","FlexiIndicationsEnum",ProcedureSpecifiValues)
FlexiIndicationsEnum<-ListContstructor("FlexiIndicationsEnum","FlexiDiagnosisLookupEnum",ProcedureSpecifiValues)
FlexiDiagnosisLookupEnum<-ListContstructor("FlexiDiagnosisLookupEnum","FlexiTherapeuticLookupEnum",ProcedureSpecifiValues)
FlexiTherapeuticLookupEnum<-ListContstructor("FlexiTherapeuticLookupEnum","FlexiBiopsyEnum",ProcedureSpecifiValues)
FlexiBiopsyEnum<-ListContstructor("FlexiBiopsyEnum","FlexiBowelPrepEnum",ProcedureSpecifiValues)
FlexiBowelPrepEnum<-ListContstructor("FlexiBowelPrepEnum","FlexiTattooEnum",ProcedureSpecifiValues)
FlexiTattooEnum<-ListContstructor("FlexiTattooEnum","ERCPTattooEnum",ProcedureSpecifiValues)

#Multiple
FlexiTherapeuticType<-paste(replicate(10,sample(paste("Therapy: ",FlexiTherapeuticLookupEnum),1)),
                            replicate(10,sample(paste("Biopsy: ",FlexiBiopsyEnum),1)),
                            replicate(10,sample(paste("PolypSize: ",GeneralPolypSizeEnum[[1]]),1)),
                            replicate(10,sample(paste("Tattoo: ",FlexiTattooEnum),1)))

#Multiple
FlexiBiopsyType<-paste(replicate(10,paste("Biopsy site:",sample(FlexiBiopsyEnum[[1]])),1),"Number of biopsies: ",sample(1:8))

FlexiDiagnoseType<-paste(replicate(10,paste("Diagnosis:",sample(FlexiDiagnosisLookupEnum,1))),
                         replicate(10,paste("Biopsy site:",sample(FlexiBiopsyEnum,1))))

#Multiple
FlexiIndicationType<-replicate(10,paste("Indications:",sample(FlexiIndicationsEnum,1)))
FlexiLimitationType<-replicate(10,paste("Limitations:",sample(FlexiLimitationsEnum,1)))

FlexiStaffType<-paste(replicate(10,paste(FlexiTherapeuticType,1)),
                      replicate(10,paste("Endoscopist Role:",sample(GeneralEndoscopistRoleTypeEnum[[1]],1))),
                      replicate(10,paste("Procedure Role:",sample(GeneralProcedureRoleTypeEnum[[1]],1))),
                      replicate(10,paste("Extent Type:",sample(FlexiExtentTypeEnum,1))),
                      replicate(10,paste("jManoeuvre:",sample(GeneralYesNoEnum,1))))


FlexiProcedureType<- paste(replicate(10,sample(PatientType,1)),
                           replicate(10,sample(paste("Pethidine: ",sample(seq(12.5,100,12.5),1),"mcg")),1),
                           replicate(10,sample(paste("Midazolam: ",sample(seq(0.5,10,0.5),1),"mg")),1),
                           replicate(10,sample(paste("Fentanyl: ",sample(seq(12.5,100,12.5),1),"mg")),1),
                           replicate(10,sample(paste("Buscopan: ",sample(seq(10,30,10),1),"mg")),1),
                           replicate(10,sample(paste("Propofol: ",sample(seq(12.5,100,12.5),1),"mg")),1),
                           replicate(10,sample(FlexiStaffType,1)),
                           replicate(10,sample(FlexiIndicationType,1)),
                           replicate(10,sample(FlexiLimitationType,1)),
                           replicate(10,sample(FlexiBiopsyType,1)),
                           replicate(10,sample(AdverseEventType,1)),
                           replicate(10,sample(FlexiDiagnoseType,1)),
                           replicate(10,paste("Procedure:Flexi")),
                           replicate(10,paste("Discomfort:",sample(GeneralDiscomfortEnum[[1]],1))),
                           replicate(10,paste("Discomfort:",sample(GeneralDiscomfortEnum[[1]],1))),
                           replicate(10,paste("Extent:",sample(FlexiExtentTypeEnum,1))),
                           paste("antibioticGiven:",replicate(10,sample(GeneralYesNoEnum,1))),
                           paste("digitalRectalExamination",replicate(10,sample(GeneralYesNoEnum,1))),
                           paste("magneticEndoscopeImagerUsed:",replicate(10,sample(GeneralYesNoEnum,1))))