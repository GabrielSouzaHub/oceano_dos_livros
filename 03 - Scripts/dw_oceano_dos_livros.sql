
CREATE TABLE public.dim_data (
                sk_data INTEGER NOT NULL,
                nk_data DATE NOT NULL,
                desc_data_completa VARCHAR(60) NOT NULL,
                nr_ano INTEGER NOT NULL,
                nm_trimestre VARCHAR(20) NOT NULL,
                nr_ano_trimestre VARCHAR(20) NOT NULL,
                nr_mes INTEGER NOT NULL,
                nm_mes VARCHAR(20) NOT NULL,
                ano_mes VARCHAR(20) NOT NULL,
                nr_semana INTEGER NOT NULL,
                ano_semana VARCHAR(20) NOT NULL,
                nr_dia INTEGER NOT NULL,
                nr_dia_ano INTEGER NOT NULL,
                nm_dia_semana VARCHAR(20) NOT NULL,
                flag_final_semana CHAR(3) NOT NULL,
                flag_feriado CHAR(3) NOT NULL,
                nm_feriado VARCHAR(60) NOT NULL,
                etl_dt_inicio TIMESTAMP NOT NULL,
                etl_dt_fim TIMESTAMP NOT NULL,
                CONSTRAINT sk_data_pk PRIMARY KEY (sk_data)
);


CREATE SEQUENCE public.dm_avaliacao_sk_avaliacao_seq;

CREATE TABLE public.dm_avaliacao (
                sk_avaliacao INTEGER NOT NULL DEFAULT nextval('public.dm_avaliacao_sk_avaliacao_seq'),
                nk_avaliacao INTEGER NOT NULL,
                nota VARCHAR(50) NOT NULL,
                etl_versao INTEGER NOT NULL,
                etl_dt_inicio DATE NOT NULL,
                etl_dt_fim DATE NOT NULL,
                CONSTRAINT sk_avaliacao PRIMARY KEY (sk_avaliacao)
);


ALTER SEQUENCE public.dm_avaliacao_sk_avaliacao_seq OWNED BY public.dm_avaliacao.sk_avaliacao;

CREATE SEQUENCE public.dm_cliente_sk_cliente_seq;

CREATE SEQUENCE public.dm_cliente_nk_cliente_seq;

CREATE TABLE public.dm_cliente (
                sk_cliente INTEGER NOT NULL DEFAULT nextval('public.dm_cliente_sk_cliente_seq'),
                nk_cliente INTEGER NOT NULL DEFAULT nextval('public.dm_cliente_nk_cliente_seq'),
                nome VARCHAR(50) NOT NULL,
                idade INTEGER NOT NULL,
                sexo VARCHAR(50) NOT NULL,
                bairro VARCHAR(50) NOT NULL,
                etl_dt_versao INTEGER NOT NULL,
                etl_dt_inicio DATE NOT NULL,
                etl_dt_fim DATE NOT NULL,
                CONSTRAINT sk_cliente PRIMARY KEY (sk_cliente)
);


ALTER SEQUENCE public.dm_cliente_sk_cliente_seq OWNED BY public.dm_cliente.sk_cliente;

ALTER SEQUENCE public.dm_cliente_nk_cliente_seq OWNED BY public.dm_cliente.nk_cliente;

CREATE SEQUENCE public.dm_livro_sk_livro_seq;

CREATE TABLE public.dm_livro (
                sk_livro INTEGER NOT NULL DEFAULT nextval('public.dm_livro_sk_livro_seq'),
                nk_livro INTEGER NOT NULL,
                genero VARCHAR(8) NOT NULL,
                titulo VARCHAR(25) NOT NULL,
                valor_compra INTEGER NOT NULL,
                valor_venda INTEGER NOT NULL,
                etl_versao INTEGER NOT NULL,
                etl_dt_inicio DATE NOT NULL,
                etl_dt_fim DATE NOT NULL,
                CONSTRAINT sk_livro PRIMARY KEY (sk_livro)
);


ALTER SEQUENCE public.dm_livro_sk_livro_seq OWNED BY public.dm_livro.sk_livro;

CREATE TABLE public.ft_venda (
                sk_livro INTEGER NOT NULL,
                sk_cliente INTEGER NOT NULL,
                sk_avaliacao INTEGER NOT NULL,
                dd_id_venda INTEGER NOT NULL,
                dd_quantidade INTEGER NOT NULL,
                sk_data INTEGER NOT NULL,
                md_valor_total REAL NOT NULL
);


ALTER TABLE public.ft_venda ADD CONSTRAINT dim_data_ft_venda_fk
FOREIGN KEY (sk_data)
REFERENCES public.dim_data (sk_data)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ft_venda ADD CONSTRAINT avaliacao_venda_fk
FOREIGN KEY (sk_avaliacao)
REFERENCES public.dm_avaliacao (sk_avaliacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ft_venda ADD CONSTRAINT dm_cliente_venda_fk
FOREIGN KEY (sk_cliente)
REFERENCES public.dm_cliente (sk_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ft_venda ADD CONSTRAINT dm_livro_venda_fk
FOREIGN KEY (sk_livro)
REFERENCES public.dm_livro (sk_livro)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
