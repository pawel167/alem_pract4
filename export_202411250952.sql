-- DROP SCHEMA public;

CREATE SCHEMA public AUTHORIZATION postgres;

COMMENT ON SCHEMA public IS 'standard public schema';

-- DROP SEQUENCE public.ozerov_225_orders_count_seq;

CREATE SEQUENCE public.ozerov_225_orders_count_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE public.ozerov_225_orders_count_seq OWNER TO postgres;
GRANT ALL ON SEQUENCE public.ozerov_225_orders_count_seq TO postgres;

-- DROP SEQUENCE public.ozerov_225_orders_id_order_seq;

CREATE SEQUENCE public.ozerov_225_orders_id_order_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE public.ozerov_225_orders_id_order_seq OWNER TO postgres;
GRANT ALL ON SEQUENCE public.ozerov_225_orders_id_order_seq TO postgres;

-- DROP SEQUENCE public.ozerov_225_orders_id_product_seq;

CREATE SEQUENCE public.ozerov_225_orders_id_product_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE public.ozerov_225_orders_id_product_seq OWNER TO postgres;
GRANT ALL ON SEQUENCE public.ozerov_225_orders_id_product_seq TO postgres;

-- DROP SEQUENCE public.ozerov_225_orders_id_shop_seq;

CREATE SEQUENCE public.ozerov_225_orders_id_shop_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE public.ozerov_225_orders_id_shop_seq OWNER TO postgres;
GRANT ALL ON SEQUENCE public.ozerov_225_orders_id_shop_seq TO postgres;

-- DROP SEQUENCE public.ozerov_225_products_id_product_seq;

CREATE SEQUENCE public.ozerov_225_products_id_product_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE public.ozerov_225_products_id_product_seq OWNER TO postgres;
GRANT ALL ON SEQUENCE public.ozerov_225_products_id_product_seq TO postgres;

-- DROP SEQUENCE public.ozerov_225_shop_id_shop_seq;

CREATE SEQUENCE public.ozerov_225_shop_id_shop_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE public.ozerov_225_shop_id_shop_seq OWNER TO postgres;
GRANT ALL ON SEQUENCE public.ozerov_225_shop_id_shop_seq TO postgres;
-- public.ozerov_225_products definition

-- Drop table

-- DROP TABLE ozerov_225_products;

CREATE TABLE ozerov_225_products (
	id_product serial4 NOT NULL,
	product_name varchar NOT NULL,
	count_product int4 NOT NULL,
	price money NULL,
	CONSTRAINT ozerov_225_products_pk PRIMARY KEY (id_product)
);

-- Permissions

ALTER TABLE public.ozerov_225_products OWNER TO postgres;
GRANT ALL ON TABLE public.ozerov_225_products TO postgres;


-- public.ozerov_225_shop definition

-- Drop table

-- DROP TABLE ozerov_225_shop;

CREATE TABLE ozerov_225_shop (
	id_shop serial4 NOT NULL,
	stote_name varchar NOT NULL,
	address varchar NULL,
	phone varchar NULL,
	contact_person varchar NULL,
	CONSTRAINT ozerov_225_shop_pk PRIMARY KEY (id_shop)
);

-- Permissions

ALTER TABLE public.ozerov_225_shop OWNER TO postgres;
GRANT ALL ON TABLE public.ozerov_225_shop TO postgres;


-- public.ozerov_225_orders definition

-- Drop table

-- DROP TABLE ozerov_225_orders;

CREATE TABLE ozerov_225_orders (
	id_order serial4 NOT NULL,
	id_shop serial4 NOT NULL,
	id_product serial4 NOT NULL,
	count serial4 NOT NULL,
	date_order date NULL,
	CONSTRAINT ozerov_225_orders_pk PRIMARY KEY (id_order),
	CONSTRAINT ozerov_225_orders_fk FOREIGN KEY (id_shop) REFERENCES ozerov_225_shop(id_shop) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT ozerov_225_orders_fk_1 FOREIGN KEY (id_product) REFERENCES ozerov_225_products(id_product) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Permissions

ALTER TABLE public.ozerov_225_orders OWNER TO postgres;
GRANT ALL ON TABLE public.ozerov_225_orders TO postgres;




-- Permissions

GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO public;
INSERT INTO public.ozerov_225_orders (id_order,id_shop,id_product,count,date_order) VALUES
	 (1,1,1,1,'2024-10-27'),
	 (2,2,2,1,'2024-10-07');
INSERT INTO public.ozerov_225_products (id_product,product_name,count_product,price) VALUES
	 (1,'компьютерная мышь',8,450,00 ₽),
	 (2,'клавиатура',12,900,00 ₽),
	 (3,'коврик для мыши',100,299,00 ₽);
INSERT INTO public.ozerov_225_shop (id_shop,stote_name,address,phone,contact_person) VALUES
	 (1,'мир компьютеров','энгельса','89872241239','иванов павел'),
	 (2,'электроник','ленина','89123012143','васильев алексей');
