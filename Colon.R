ColonExtentTypeEnum<-ListContstructor("ColonExtentTypeEnum","ColonLimitationsEnum",ProcedureSpecifiValues)
ColonLimitationsEnum<-ListContstructor("ColonLimitationsEnum","ColonIndicationsEnum",ProcedureSpecifiValues)
ColonIndicationsEnum<-ListContstructor("ColonIndicationsEnum","ColonDiagnosisLookupEnum",ProcedureSpecifiValues)
ColonDiagnosisLookupEnum<-ListContstructor("ColonDiagnosisLookupEnum","ColonTherapeuticLookupEnum",ProcedureSpecifiValues)
ColonTherapeuticLookupEnum<-ListContstructor("ColonTherapeuticLookupEnum","ColonBiopsyEnum",ProcedureSpecifiValues)
ColonBiopsyEnum<-ListContstructor("ColonBiopsyEnum","ColonBowelPrepEnum",ProcedureSpecifiValues)
ColonBowelPrepEnum<-ListContstructor("ColonBowelPrepEnum","ColonTattooEnum",ProcedureSpecifiValues)
ColonTattooEnum<-ListContstructor("ColonTattooEnum","FlexiExtentTypeEnum",ProcedureSpecifiValues)

ColonTherapeuticType<-paste(replicate(10,sample(paste("Therapy: ",ColonTherapeuticLookupEnum),1)),
                            replicate(10,sample(paste("Biopsy: ",ColonBiopsyEnum),1)),
                            replicate(10,sample(paste("PolypSize: ",GeneralPolypSizeEnum[[1]]),1)),
                            replicate(10,sample(paste("Tattoo: ",OGDTattooEnum),1)))

ColonBiopsyType<-paste(replicate(10,paste("Biopsy site:",sample(ColonBiopsyEnum)),1),"Number of biopsies: ",sample(1:8))

ColonDiagnoseType<-paste(replicate(10,paste("Diagnosis:",sample(ColonDiagnosisLookupEnum,1))),
                         replicate(10,paste("Biopsy site:",sample(ColonBiopsyEnum,1))))

ColonIndicationType<-replicate(10,paste("Indications:",sample(ColonIndicationsEnum,1)))
ColonLimitationType<-replicate(10,paste("Limitations:",sample(ColonLimitationsEnum,1)))

ColonStaffType<-paste(replicate(10,paste(ColonTherapeuticType,1)),
                      replicate(10,paste("Endoscopist Role:",sample(GeneralEndoscopistRoleTypeEnum[[1]],1))),
                      replicate(10,paste("Procedure Role:",sample(GeneralProcedureRoleTypeEnum[[1]],1))),
                      replicate(10,paste("Extent Type:",sample(ColonExtentTypeEnum,1))),
                      replicate(10,paste("jManoeuvre:",sample(GeneralYesNoEnum,1))))


ColonProcedureType<- paste(replicate(10,sample(PatientType,1)),
                           replicate(10,sample(paste("Meds:",GeneralDrugType[[1]])),1),
                           replicate(10,sample(ColonStaffType,1)),
                           replicate(10,sample(ColonIndicationType,1)),
                           replicate(10,sample(ColonLimitationType,1)),
                           replicate(10,sample(ColonBiopsyType,1)),
                           replicate(10,sample(AdverseEventType,1)),
                           replicate(10,sample(ColonDiagnoseType,1)),
                           replicate(10,paste("Procedure:Colon")),
                           replicate(10,paste("Discomfort:",sample(GeneralDiscomfortEnum[[1]],1))),
                           replicate(10,paste("Discomfort:",sample(GeneralDiscomfortEnum[[1]],1))),
                           replicate(10,paste("Extent:",sample(ColonExtentTypeEnum,1))),
                           paste("entonox:",replicate(10,sample(GeneralYesNoEnum,1))),
                           paste("antibioticGiven:",replicate(10,sample(GeneralYesNoEnum,1))),
                           paste("generalAnaes:",replicate(10,sample(GeneralYesNoEnum,1))),
                           paste("pharyngealAnaes:",replicate(10,sample(GeneralYesNoEnum,1))),
                           paste("digitalRectalExamination",replicate(10,sample(GeneralYesNoEnum,1))),
                           paste("magneticEndoscopeImagerUsed:",replicate(10,sample(GeneralYesNoEnum,1))))