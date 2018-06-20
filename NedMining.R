
dfw <-read_excel("/home/rstudio/NEDMineR/data/NED Terms in XML.xlsx","NED Enumeration Values")
library(readxl)
library(stringr)
library(dplyr)
library(tidyverse)
names(dfw)<-c("groups","values")
dfw<-data.frame(dfw[1:2])
data_out <- dfw %>%
  group_by(groups) %>%
  nest(values)


#Heirarchy of report synthesis


ProcedureNameEnum<-as.list(data_out[[16,2]])

#GeneralEnums
SessionTypeEnum<-as.list(data_out[[2,2]])
AdmissionTypeEnum<-as.list(data_out[[5,2]])
UrgencyEnum<-as.list(data_out[[6,2]])
ProcedureRoleTypeEnum<-as.list(data_out[[7,2]])
EndoscopistRoleTypeEnum<-as.list(data_out[[8,2]])
DiscomfortEnum<-as.list(data_out[[9,2]])
AdverseEventEnum<-as.list(data_out[[14,2]])

#OGDEnums
ExtentTypeEnum<-as.list(data_out[[3,2]])
LimitationsEnum<-as.list(data_out[[4,2]])
IndicationsEnum<-as.list(data_out[[10,2]])
DiagnosisLookupEnum<-as.list(data_out[[11,2]])
TherapeuticLookupEnum<-as.list(data_out[[12,2]])
BiopsyEnum<-as.list(data_out[[13,2]])
GenderType<-as.list(data_out[[17,2]])
YesNoEnum<-as.list(data_out[[18,2]])
PolypSizeEnum<-as.list(data_out[[19,2]])
TimeEnum<-as.list(data_out[[21,2]])
DrugType<-as.list(data_out[[22,2]])
YesNoEnum<-as.list(c("Yes","No"))

#FlexiEnums
ExtentTypeEnum<-as.list(data_out[[3,2]])
LimitationsEnum<-as.list(data_out[[4,2]])
IndicationsEnum<-as.list(data_out[[10,2]])
DiagnosisLookupEnum<-as.list(data_out[[11,2]])
TherapeuticLookupEnum<-as.list(data_out[[12,2]])
BiopsyEnum<-as.list(data_out[[13,2]])
GenderType<-as.list(data_out[[17,2]])
YesNoEnum<-as.list(data_out[[18,2]])
PolypSizeEnum<-as.list(data_out[[19,2]])
TimeEnum<-as.list(data_out[[21,2]])
DrugType<-as.list(data_out[[22,2]])
YesNoEnum<-as.list(c("Yes","No"))
BowelPrepEnum<-as.list(data_out[[15,2]])
TattooEnum<-as.list(data_out[[20,2]])

#ColonEnums
ExtentTypeEnum<-as.list(data_out[[3,2]])
LimitationsEnum<-as.list(data_out[[4,2]])
IndicationsEnum<-as.list(data_out[[10,2]])
DiagnosisLookupEnum<-as.list(data_out[[11,2]])
TherapeuticLookupEnum<-as.list(data_out[[12,2]])
BiopsyEnum<-as.list(data_out[[13,2]])
GenderType<-as.list(data_out[[17,2]])
YesNoEnum<-as.list(data_out[[18,2]])
PolypSizeEnum<-as.list(data_out[[19,2]])
TimeEnum<-as.list(data_out[[21,2]])
DrugType<-as.list(data_out[[22,2]])
YesNoEnum<-as.list(c("Yes","No"))
BowelPrepEnum<-as.list(data_out[[15,2]])
TattooEnum<-as.list(data_out[[20,2]])

#ERCPEnums
ExtentTypeEnum<-as.list(data_out[[3,2]])
LimitationsEnum<-as.list(data_out[[4,2]])
IndicationsEnum<-as.list(data_out[[10,2]])
DiagnosisLookupEnum<-as.list(data_out[[11,2]])
TherapeuticLookupEnum<-as.list(data_out[[12,2]])
BiopsyEnum<-as.list(data_out[[13,2]])
GenderType<-as.list(data_out[[17,2]])
YesNoEnum<-as.list(data_out[[18,2]])
PolypSizeEnum<-as.list(data_out[[19,2]])
TimeEnum<-as.list(data_out[[21,2]])
DrugType<-as.list(data_out[[22,2]])
YesNoEnum<-as.list(c("Yes","No"))


########################### Creating the General enums of enum ####################################################################################################################################### 
PatientType<- paste(replicate(10,sample(paste("Gender: ",GenderType[[1]]),1)),replicate(10,sample(paste("Age: ",18:99))),replicate(10,sample(paste("Admission Type: ",AdmissionTypeEnum[[1]]),1)),replicate(10,sample(paste("Urgency: ",UrgencyEnum[[1]]),1,replace=F)))
AdverseEventType<-replicate(10,sample(paste("Adverse Event: ",AdverseEventEnum[[1]]),1))




TherapeuticType<-paste(replicate(10,sample(paste("Therapeutic: ",TherapeuticLookupEnum[[1]]),1)),replicate(10,sample(paste("Biopsy: ",BiopsyEnum[[1]]),1)),replicate(10,sample(paste("Procedure Role: ",ProcedureRoleTypeEnum[[1]]),1)),replicate(10,sample(paste("PolypSize: ",PolypSizeEnum[[1]]),1)),replicate(10,sample(paste("Tattoo: ",TattooEnum[[1]]),1)))
BiopsyType<-paste(replicate(10,paste("Biopsy site:",sample(BiopsyEnum[[1]])),1),"Number of biopsies: ",sample(1:8))

DiagnoseType<-paste(replicate(10,paste("Diagnosis:",sample(DiagnosisLookupEnum[[1]],1))),replicate(10,paste("Tattoo:",sample(TattooEnum[[1]],1))),replicate(10,paste("Biopsy site:",sample(BiopsyEnum[[1]]),1)))


IndicationType<-replicate(10,paste("Biopsy site:",sample(IndicationsEnum[[1]],1)))
LimitationType<-replicate(10,paste("Limitations:",sample(LimitationsEnum[[1]],1)))
StaffType<-paste(replicate(10,paste("Limitations:",sample(TherapeuticLookupEnum[[1]],1))),replicate(10,paste("Endoscopist Role:",sample(EndoscopistRoleTypeEnum[[1]],1))),replicate(10,paste("Procedure Role:",sample(ProcedureRoleTypeEnum[[1]],1))),replicate(10,paste("Extent Type:",sample(ExtentTypeEnum[[1]],1))),replicate(10,paste("Limitations:",sample(ExtentTypeEnum[[1]],1))),"jManoeuvre:",paste("jManoeuvre:",sample(YesNoEnum,1)))


ProcedureType<- paste(replicate(10,sample(PatientType,1)),
replicate(10,sample(DrugType[[1]]),1),
replicate(10,sample(StaffType,1)),
replicate(10,sample(IndicationType,1)),
replicate(10,sample(LimitationType,1)),
replicate(10,sample(BiopsyType,1)),
replicate(10,sample(AdverseEventType,1)),
replicate(10,sample(DiagnoseType,1)),
replicate(10,paste("Procedure:",sample(ProcedureNameEnum[[1]],1))),
replicate(10,paste("Discomfort:",sample(DiscomfortEnum[[1]],1))),
replicate(10,paste("Discomfort:",sample(DiscomfortEnum[[1]],1))),
replicate(10,paste("Bowel Prep:",sample(BowelPrepEnum[[1]],1))),
replicate(10,paste("Extent:",sample(ExtentTypeEnum[[1]],1))),
paste("entonox:",replicate(10,sample(YesNoEnum,1))),
paste("antibioticGiven:",replicate(10,sample(YesNoEnum,1))),
      paste("generalAnaes:",replicate(10,sample(YesNoEnum,1))),
            paste("pharyngealAnaes:",replicate(10,sample(YesNoEnum,1))),
                  paste("digitalRectalExamination",replicate(10,sample(YesNoEnum,1))),
                        paste("magneticEndoscopeImagerUsed:",replicate(10,sample(YesNoEnum,1))))


UKDateType<-sample(seq(as.Date('1999/01/01'), as.Date('2000/01/01'), by="day"), 365)
hourTime<-(seq.POSIXt(as.POSIXct(Sys.Date()),
                      as.POSIXct(Sys.Date()+1),
                      by = "5 min"))

t<-as.character(hourTime)
TimeEnum<-str_extract(t," .*")

SessionType<-paste(replicate(10,sample(ProcedureType,1)),replicate(10,sample(UKDateType, 12)),replicate(10,sample(hourTimeExtracted[[1]],1)),replicate(10,sample(SessionTypeEnum[[1]],1)))






#to Do:
#Make the reports algorithmic so that the correct findings are for the correct procedures
#Develop function for HES_ID
#Dependent ENUMS
