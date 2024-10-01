CREATE TABLE `patient_records`(
    `record_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `patient_id` BIGINT NOT NULL,
    `hospital_id` BIGINT NULL,
    `clynic_id` BIGINT NULL,
    `date_of_entry` TIMESTAMP NOT NULL,
    `disease` LINESTRING NOT NULL,
    `doctor_id` BIGINT NOT NULL,
    `treatment_type` LINESTRING NOT NULL,
    `referral_to_hospital_id` BIGINT NOT NULL,
    `treatment_start_at` TIMESTAMP NULL,
    `treatment_end_at` TIMESTAMP NULL,
    `building_id` BIGINT NULL,
    `department_id` BIGINT NULL,
    `ward_id` BIGINT NULL,
    `bed_id` BIGINT NOT NULL,
    `temperature_when_entered` TIMESTAMP NOT NULL
);
CREATE TABLE `bed`(
    `bed_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `ward_id` BIGINT NOT NULL,
    `is_occupied` TINYINT(1) NOT NULL
);
CREATE TABLE `patient`(
    `patient_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` LINESTRING NOT NULL,
    `date_of_birth` BIGINT NOT NULL,
    `address` BIGINT NOT NULL
);
CREATE TABLE `department`(
    `department_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `building_id` BIGINT NOT NULL,
    `specialization` LINESTRING NOT NULL
);
CREATE TABLE `staff`(
    `staff_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` LINESTRING NOT NULL,
    `age` BIGINT NOT NULL,
    `role` LINESTRING NOT NULL,
    `work_experience` BIGINT NOT NULL
);
CREATE TABLE `laboratory_contracts`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `lab_id` BIGINT NOT NULL,
    `hospital_id` BIGINT NULL,
    `clynic_id` BIGINT NULL,
    `is_active` TINYINT(1) NOT NULL
);
CREATE TABLE `hospital`(
    `hospital_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` LINESTRING NOT NULL,
    `address` BIGINT NOT NULL,
    `specialization` LINESTRING NOT NULL
);
CREATE TABLE `clynic`(
    `clynic_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `hospital_id` BIGINT NULL,
    `name` LINESTRING NOT NULL
);
CREATE TABLE `referral`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `from_polyclinic_id` BIGINT NOT NULL,
    `to_hospital_id` BIGINT NOT NULL,
    `patient_id` BIGINT NOT NULL,
    `specialization` BIGINT NOT NULL,
    `referral_date` BIGINT NOT NULL
);
CREATE TABLE `Employment`(
    `employment_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `doctor_id` BIGINT NULL,
    `staff_id` BIGINT NULL,
    `name` LINESTRING NOT NULL,
    `hospital_id` BIGINT NULL,
    `clynic_id` BIGINT NULL,
    `is_active` TINYINT(1) NOT NULL
);
CREATE TABLE `laboratory_test`(
    `test_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `lab_id` BIGINT NOT NULL,
    `test_name` BIGINT NOT NULL,
    `test_date` TIMESTAMP NOT NULL,
    `patient_id` BIGINT NOT NULL,
    `result` TEXT NOT NULL,
    `hospital_id` BIGINT NULL,
    `clynic_id` BIGINT NULL
);
CREATE TABLE `building`(
    `building_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `hospital_id` BIGINT NOT NULL,
    `name` LINESTRING NOT NULL,
    `address` BIGINT NOT NULL
);
CREATE TABLE `ward`(
    `ward_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `department_id` BIGINT NOT NULL,
    `capacity` BIGINT NOT NULL,
    `filled_status` BIGINT NOT NULL
);
CREATE TABLE `laboratory`(
    `lab_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` LINESTRING NOT NULL,
    `specialization` LINESTRING NOT NULL,
    `adress` BIGINT NOT NULL
);
CREATE TABLE `doctor`(
    `doctor_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` LINESTRING NOT NULL,
    `specialization` LINESTRING NOT NULL,
    `work_experience_in_years` BIGINT NOT NULL,
    `degree` LINESTRING NOT NULL,
    `can_work_in_many_institutions` TINYINT(1) NOT NULL,
    `age` BIGINT NOT NULL,
    `num_of_operations` BIGINT NULL,
    `num_of_fatal_operations` BIGINT NULL,
    `salary_coef_for_harmful_conditions` BIGINT NULL,
    `extra_vacation_days` BIGINT NULL
);
ALTER TABLE
    `department` ADD CONSTRAINT `department_building_id_foreign` FOREIGN KEY(`building_id`) REFERENCES `building`(`building_id`);
ALTER TABLE
    `clynic` ADD CONSTRAINT `clynic_hospital_id_foreign` FOREIGN KEY(`hospital_id`) REFERENCES `hospital`(`hospital_id`);
ALTER TABLE
    `patient_records` ADD CONSTRAINT `patient_records_bed_id_foreign` FOREIGN KEY(`bed_id`) REFERENCES `bed`(`bed_id`);
ALTER TABLE
    `laboratory_test` ADD CONSTRAINT `laboratory_test_clynic_id_foreign` FOREIGN KEY(`clynic_id`) REFERENCES `clynic`(`clynic_id`);
ALTER TABLE
    `Employment` ADD CONSTRAINT `employment_hospital_id_foreign` FOREIGN KEY(`hospital_id`) REFERENCES `hospital`(`hospital_id`);
ALTER TABLE
    `patient_records` ADD CONSTRAINT `patient_records_ward_id_foreign` FOREIGN KEY(`ward_id`) REFERENCES `referral`(`id`);
ALTER TABLE
    `patient_records` ADD CONSTRAINT `patient_records_hospital_id_foreign` FOREIGN KEY(`hospital_id`) REFERENCES `hospital`(`hospital_id`);
ALTER TABLE
    `building` ADD CONSTRAINT `building_hospital_id_foreign` FOREIGN KEY(`hospital_id`) REFERENCES `hospital`(`hospital_id`);
ALTER TABLE
    `patient_records` ADD CONSTRAINT `patient_records_doctor_id_foreign` FOREIGN KEY(`doctor_id`) REFERENCES `doctor`(`doctor_id`);
ALTER TABLE
    `laboratory_test` ADD CONSTRAINT `laboratory_test_hospital_id_foreign` FOREIGN KEY(`hospital_id`) REFERENCES `hospital`(`hospital_id`);
ALTER TABLE
    `patient_records` ADD CONSTRAINT `patient_records_ward_id_foreign` FOREIGN KEY(`ward_id`) REFERENCES `ward`(`ward_id`);
ALTER TABLE
    `patient_records` ADD CONSTRAINT `patient_records_patient_id_foreign` FOREIGN KEY(`patient_id`) REFERENCES `patient`(`patient_id`);
ALTER TABLE
    `bed` ADD CONSTRAINT `bed_ward_id_foreign` FOREIGN KEY(`ward_id`) REFERENCES `ward`(`ward_id`);
ALTER TABLE
    `referral` ADD CONSTRAINT `referral_from_polyclinic_id_foreign` FOREIGN KEY(`from_polyclinic_id`) REFERENCES `clynic`(`clynic_id`);
ALTER TABLE
    `patient_records` ADD CONSTRAINT `patient_records_building_id_foreign` FOREIGN KEY(`building_id`) REFERENCES `building`(`building_id`);
ALTER TABLE
    `patient_records` ADD CONSTRAINT `patient_records_clynic_id_foreign` FOREIGN KEY(`clynic_id`) REFERENCES `clynic`(`clynic_id`);
ALTER TABLE
    `referral` ADD CONSTRAINT `referral_patient_id_foreign` FOREIGN KEY(`patient_id`) REFERENCES `patient`(`patient_id`);
ALTER TABLE
    `referral` ADD CONSTRAINT `referral_to_hospital_id_foreign` FOREIGN KEY(`to_hospital_id`) REFERENCES `hospital`(`hospital_id`);
ALTER TABLE
    `Employment` ADD CONSTRAINT `employment_staff_id_foreign` FOREIGN KEY(`staff_id`) REFERENCES `staff`(`staff_id`);
ALTER TABLE
    `laboratory_contracts` ADD CONSTRAINT `laboratory_contracts_hospital_id_foreign` FOREIGN KEY(`hospital_id`) REFERENCES `hospital`(`hospital_id`);
ALTER TABLE
    `Employment` ADD CONSTRAINT `employment_doctor_id_foreign` FOREIGN KEY(`doctor_id`) REFERENCES `doctor`(`doctor_id`);
ALTER TABLE
    `laboratory_contracts` ADD CONSTRAINT `laboratory_contracts_clynic_id_foreign` FOREIGN KEY(`clynic_id`) REFERENCES `clynic`(`clynic_id`);
ALTER TABLE
    `patient_records` ADD CONSTRAINT `patient_records_department_id_foreign` FOREIGN KEY(`department_id`) REFERENCES `department`(`department_id`);
ALTER TABLE
    `Employment` ADD CONSTRAINT `employment_clynic_id_foreign` FOREIGN KEY(`clynic_id`) REFERENCES `clynic`(`clynic_id`);
ALTER TABLE
    `laboratory_test` ADD CONSTRAINT `laboratory_test_lab_id_foreign` FOREIGN KEY(`lab_id`) REFERENCES `laboratory`(`lab_id`);
ALTER TABLE
    `ward` ADD CONSTRAINT `ward_department_id_foreign` FOREIGN KEY(`department_id`) REFERENCES `department`(`department_id`);
ALTER TABLE
    `laboratory_contracts` ADD CONSTRAINT `laboratory_contracts_lab_id_foreign` FOREIGN KEY(`lab_id`) REFERENCES `laboratory`(`lab_id`);