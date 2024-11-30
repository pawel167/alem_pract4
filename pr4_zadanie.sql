-- DROP SCHEMA public;

CREATE SCHEMA public AUTHORIZATION postgres;

COMMENT ON SCHEMA public IS 'standard public schema';

-- DROP SEQUENCE public.doctor_id_doctor_seq;

CREATE SEQUENCE public.doctor_id_doctor_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE public.doctor_id_doctor_seq OWNER TO postgres;
GRANT ALL ON SEQUENCE public.doctor_id_doctor_seq TO postgres;

-- DROP SEQUENCE public.pacient_id_pacient_seq;

CREATE SEQUENCE public.pacient_id_pacient_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE public.pacient_id_pacient_seq OWNER TO postgres;
GRANT ALL ON SEQUENCE public.pacient_id_pacient_seq TO postgres;

-- DROP SEQUENCE public.priem_id_doctor_seq;

CREATE SEQUENCE public.priem_id_doctor_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE public.priem_id_doctor_seq OWNER TO postgres;
GRANT ALL ON SEQUENCE public.priem_id_doctor_seq TO postgres;

-- DROP SEQUENCE public.priem_id_pacient_seq;

CREATE SEQUENCE public.priem_id_pacient_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE public.priem_id_pacient_seq OWNER TO postgres;
GRANT ALL ON SEQUENCE public.priem_id_pacient_seq TO postgres;

-- DROP SEQUENCE public.priem_id_priem_seq;

CREATE SEQUENCE public.priem_id_priem_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE public.priem_id_priem_seq OWNER TO postgres;
GRANT ALL ON SEQUENCE public.priem_id_priem_seq TO postgres;
-- public.doctor definition

-- Drop table

-- DROP TABLE doctor;

CREATE TABLE doctor (
	fio varchar NOT NULL,
	specializaton varchar NOT NULL,
	id_doctor serial4 NOT NULL,
	CONSTRAINT doctor_pk PRIMARY KEY (id_doctor)
);

-- Permissions

ALTER TABLE public.doctor OWNER TO postgres;
GRANT ALL ON TABLE public.doctor TO postgres;


-- public.pacient definition

-- Drop table

-- DROP TABLE pacient;

CREATE TABLE pacient (
	id_pacient serial4 NOT NULL,
	"name" varchar NOT NULL,
	lastname varchar NOT NULL,
	patronymic varchar NOT NULL,
	birthdate date NOT NULL,
	address varchar NOT NULL,
	CONSTRAINT pacient_pk PRIMARY KEY (id_pacient)
);

-- Permissions

ALTER TABLE public.pacient OWNER TO postgres;
GRANT ALL ON TABLE public.pacient TO postgres;


-- public.priem definition

-- Drop table

-- DROP TABLE priem;

CREATE TABLE priem (
	id_priem serial4 NOT NULL,
	priem_date date NOT NULL,
	"cost" money NOT NULL,
	id_doctor serial4 NOT NULL,
	id_pacient serial4 NOT NULL,
	percent_zp int4 NOT NULL,
	zp money NULL,
	CONSTRAINT priem_pk PRIMARY KEY (id_priem),
	CONSTRAINT priem_fk FOREIGN KEY (id_doctor) REFERENCES doctor(id_doctor) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT priem_fk_1 FOREIGN KEY (id_pacient) REFERENCES pacient(id_pacient) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table Triggers

create trigger calculate_zp before
insert
    on
    public.priem for each row execute function zp();

-- Permissions

ALTER TABLE public.priem OWNER TO postgres;
GRANT ALL ON TABLE public.priem TO postgres;



CREATE OR REPLACE FUNCTION public.zp()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
 begin
 	new.zp = new.cost * new.percent_zp::numeric * 0.01 * 0.87;
 return new;
 end;
 $function$
;

-- Permissions

ALTER FUNCTION public.zp() OWNER TO postgres;
GRANT ALL ON FUNCTION public.zp() TO postgres;


-- Permissions

GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO public;
