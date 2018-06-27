ERCPExtentTypeEnum<-ListContstructor("ERCPExtentTypeEnum","ERCPLimitationsEnum",ProcedureSpecifiValues)
ERCPLimitationsEnum<-ListContstructor("ERCPLimitationsEnum","ERCPIndicationsEnum",ProcedureSpecifiValues)
ERCPIndicationsEnum<-ListContstructor("ERCPIndicationsEnum","ERCPDiagnosisLookupEnum",ProcedureSpecifiValues)
ERCPDiagnosisLookupEnum<-ListContstructor("ERCPDiagnosisLookupEnum","ERCPTherapeuticLookupEnum",ProcedureSpecifiValues)
ERCPTherapeuticLookupEnum<-ListContstructor("ERCPTherapeuticLookupEnum","END",ProcedureSpecifiValues)
ERCPBiopsyEnum<-ListContstructor("ERCPBiopsyEnum","ERCPExtentTypeEnum",ProcedureSpecifiValues)
ERCPTattooEnum<-ListContstructor("ERCPTattooEnum","ERCPBiopsyEnum",ProcedureSpecifiValues)


ERCPTherapeuticType<-paste(replicate(10,sample(paste("Therapy: ",ERCPTherapeuticLookupEnum),1)),
                           replicate(10,sample(paste("Biopsy: ",ERCPBiopsyEnum),1)),
                           replicate(10,sample(paste("PolypSize: ",GeneralPolypSizeEnum),1)),
                           replicate(10,sample(paste("Tattoo: ",ERCPTattooEnum),1)))

#Multiple
ERCPBiopsyType<-replicate(10,paste("Biopsy site:NA Number of biopsies: NA"))

#Multiple
ERCPDiagnoseType<-paste(replicate(10,paste("Diagnosis:",sample(ERCPDiagnosisLookupEnum,1))),
                        replicate(10,paste("Biopsy site:","NA")))


ERCPIndicationType<-replicate(10,paste("Indications:",sample(ERCPIndicationsEnum,1)))
ERCPLimitationType<-replicate(10,paste("Limitations:",sample(ERCPLimitationsEnum,1)))

#Multiple
ERCPStaffType<-paste(replicate(10,paste(ERCPTherapeuticType,1)),
                     replicate(10,paste("Endoscopist Role:",sample(GeneralEndoscopistRoleTypeEnum,1))),
                     replicate(10,paste("Procedure Role:",sample(GeneralProcedureRoleTypeEnum,1))),
                     replicate(10,paste("Extent Type:",sample(ERCPExtentTypeEnum,1))),
                     replicate(10,paste("jManoeuvre:",sample(GeneralYesNoEnum,1))))


#Multiple
ERCPProcedureType<- paste(replicate(10,sample(PatientType,1)),
                          replicate(10,sample(paste("Meds:",GeneralDrugType)),1),
                          replicate(10,sample(ERCPStaffType,1)),
                          replicate(10,sample(ERCPIndicationType,1)),
                          replicate(10,sample(ERCPLimitationType,1)),
                          replicate(10,sample(ERCPBiopsyType,1)),
                          replicate(10,sample(AdverseEventType,1)),
                          replicate(10,sample(ERCPDiagnoseType,1)),
                          replicate(10,paste("Procedure:ERCP")),
                          replicate(10,paste("Discomfort:",sample(GeneralDiscomfortEnum,1))),
                          replicate(10,paste("Discomfort:",sample(GeneralDiscomfortEnum,1))),
                          replicate(10,paste("Extent:",sample(ERCPExtentTypeEnum,1))),
                          paste("entonox:",replicate(10,sample(GeneralYesNoEnum,1))),
                          paste("antibioticGiven:",replicate(10,sample(GeneralYesNoEnum,1))),
                          paste("generalAnaes:",replicate(10,sample(GeneralYesNoEnum,1))),
                          paste("pharyngealAnaes:",replicate(10,sample(GeneralYesNoEnum,1))),
                          paste("digitalRectalExamination",replicate(10,sample(GeneralYesNoEnum,1))),
                          paste("magneticEndoscopeImagerUsed:",replicate(10,sample(GeneralYesNoEnum,1))))

