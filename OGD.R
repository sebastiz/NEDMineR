OGDExtentTypeEnum<-ListContstructor("OGDExtentTypeEnum","OGDLimitationsEnum",ProcedureSpecifiValues)
OGDLimitationsEnum<-ListContstructor("OGDLimitationsEnum","OGDIndicationsEnum",ProcedureSpecifiValues)
OGDIndicationsEnum<-ListContstructor("OGDIndicationsEnum","OGDDiagnosisLookupEnum",ProcedureSpecifiValues)
OGDDiagnosisLookupEnum<-ListContstructor("OGDDiagnosisLookupEnum","OGDTherapeuticLookupEnum",ProcedureSpecifiValues)
OGDTherapeuticLookupEnum<-ListContstructor("OGDTherapeuticLookupEnum","OGDBiopsyEnum",ProcedureSpecifiValues)
OGDBiopsyEnum<-ListContstructor("OGDBiopsyEnum","ColonExtentTypeEnum",ProcedureSpecifiValues)
OGDTattooEnum<-ListContstructor("OGDTattooEnum","OGDExtentTypeEnum",ProcedureSpecifiValues)

#Multiple
OGDTherapeuticType<-paste(replicate(10,sample(paste("Therapy: ",OGDTherapeuticLookupEnum),1)),
                          replicate(10,sample(paste("Biopsy: ",OGDBiopsyEnum),1)),
                          replicate(10,sample(paste("PolypSize: ",GeneralPolypSizeEnum),1)),
                          replicate(10,sample(paste("Tattoo: ",OGDTattooEnum),1)))
#Multiple
OGDBiopsyType<-paste(replicate(10,paste("Biopsy site:",sample(OGDBiopsyEnum)),1),"Number of biopsies: ",sample(1:8))

OGDDiagnoseType<-paste(replicate(10,paste("Diagnosis:",sample(OGDDiagnosisLookupEnum,2))),
                       replicate(10,paste("Biopsy site:",sample(OGDBiopsyEnum,2))))
#Multiple
OGDIndicationType<-replicate(10,paste("Indications:",sample(OGDIndicationsEnum,1)))
OGDLimitationType<-replicate(10,paste("Limitations:",sample(OGDLimitationsEnum,1)))

#Multiple for each staff type - and ascribable to each staff type trainer or trainee- will need to be nested
OGDStaffType<-paste(replicate(10,as.character(unlist(sample(OGDTherapeuticType,sample(1:4))))),
                    replicate(10,paste("Endoscopist Role:",sample(GeneralEndoscopistRoleTypeEnum,1))),
                    replicate(10,paste("Procedure Role:",sample(GeneralProcedureRoleTypeEnum,1))),
                    replicate(10,paste("Extent Type:",sample(OGDExtentTypeEnum,1))),
                    replicate(10,paste("jManoeuvre:",sample(GeneralYesNoEnum,1))))


#The composite:
OGDProcedureType<- paste(replicate(10,sample(PatientType,1)),
                         replicate(10,sample(paste("Pethidine: ",sample(seq(12.5,100,12.5),1),"mcg")),1),
                         replicate(10,sample(paste("Midazolam: ",sample(seq(0.5,10,0.5),1),"mg")),1),
                         replicate(10,sample(paste("Fentanyl: ",sample(seq(12.5,100,12.5),1),"mg")),1),
                         replicate(10,sample(paste("Buscopan: ",sample(seq(10,30,10),1),"mg")),1),
                         replicate(10,sample(paste("Propofol: ",sample(seq(12.5,100,12.5),1),"mg")),1),
                         paste("entonox:",replicate(10,sample(GeneralYesNoEnum,1))),
                         paste("generalAnaes:",replicate(10,sample(GeneralYesNoEnum,1))),
                         paste("pharyngealAnaes:",replicate(10,sample(GeneralYesNoEnum,1))),
                         replicate(10,sample(OGDStaffType,1)),
                         replicate(10,sample(OGDIndicationType,1)),
                         replicate(10,sample(OGDLimitationType,1)),
                         replicate(10,sample(OGDBiopsyType,1)),
                         replicate(10,sample(AdverseEventType,1)),
                         replicate(10,sample(OGDDiagnoseType,1)),
                         replicate(10,paste("Procedure:OGD")),
                         replicate(10,paste("Discomfort:",sample(GeneralDiscomfortEnum[[1]],1))),
                         replicate(10,paste("Discomfort:",sample(GeneralDiscomfortEnum[[1]],1))),
                         replicate(10,paste("Extent:",sample(OGDExtentTypeEnum,1))),
                         paste("antibioticGiven:",replicate(10,sample(GeneralYesNoEnum,1))),
                         paste("digitalRectalExamination:",replicate(10,sample(GeneralYesNoEnum,1))),
                         paste("magneticEndoscopeImagerUsed:",replicate(10,sample(GeneralYesNoEnum,1))))
