/* A tabela "sistemas" armazena informações gerais sobre os sistemas disponíveis, como o nome e descrição. O campo "id" é usado como chave primária e é gerado automaticamente pelo MySQL. */ /* */

/* necessário implementar a ligação do usuario com o profissional de fato */
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    senha VARCHAR(255) NOT NULL,
    data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
/* AUTENTICAÇÃO COM JWT - IREMOS GUARDAR O TOKEN NO BANCO DE DADOS */
CREATE TABLE tokens_jwt (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario_token INT NOT NULL,
    token VARCHAR(255) NOT NULL,
    data_criacao TIMESTAMP NOT NULL,
    data_expiracao TIMESTAMP NOT NULL,
    FOREIGN KEY (id_usuario_token) REFERENCES usuarios(id)
);

/* TABELAS QUE GERENCIAM O PERFIL DE ACESSO DO USARIO, DIZENDO QUAIS SISTEMAS
ELE TEM ACESSO E O SEU NIVEL DE ACESSO NELES 
UM PROFISSIONAL PODE TER ACESSO A VARIOS SISTEMAS E ESSE ACESSO PODE SER DE NIVEL DIFERENTES
EM CADA UM DELES */

CREATE TABLE sistemas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao VARCHAR(255) NOT NULL
    img_sistema VARCHAR(255),
);
/* nome dos perfis de acesso - a essa tabela vai ser atribuiada as permissões */
CREATE TABLE perfis_acesso (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL
);
/* criação das funcionalidades - nome das funções o qual servirá pra linkar as permissões*/
CREATE TABLE funcionalidades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL
);
/* será armazenado os tipos de permissões como exemplo coloquei permissões basicas
isso poderá ser revisto */
CREATE TABLE permissoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    perfil_id INT NOT NULL,
    funcionalidade_id INT NOT NULL,
    visualizar_dados BOOLEAN NOT NULL,
    editar_dados BOOLEAN NOT NULL,
    deletar_dados BOOLEAN NOT NULL,
    criar_dados BOOLEAN NOT NULL,
    FOREIGN KEY (perfil_id) REFERENCES perfis_acesso(id),
    FOREIGN KEY (funcionalidade_id) REFERENCES funcionalidades(id)
);

/* De fato essa será o que gerenciará o acesso do usuario ao sistema, poderá ser implementado aqui o acesso por lotação com a inclusão de uma coluna lotação. Nessa forma será necessário criar um acesso para cada lotação */

CREATE TABLE acesso_usuario_sistema (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    id_usuario INT NOT NULL,
    id_sistema INT NOT NULL,
    perfil_id_sistema INT NOT NULL,
    status_acesso BOOLEAN NOT NULL,
    data_create TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    data_mod TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    FOREIGN KEY (perfil_id_sistema) REFERENCES perfis_acesso(id),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
    FOREIGN KEY (id_sistema) REFERENCES sistemas(id),
);

/* informações DEFAULT para o funcionamento do sistema */
INSERT INTO usuarios (nome,  email,  senha) VALUES ('master', 'master@master.com', '12345');

INSERT INTO sistemas (nome, descricao, img_sistema) VALUES ('Sistema', 'Administração da Instação', '/CAS/assets/img/fav.ICON.svg' );

INSERT INTO perfis_acesso (nome) VALUES ('MASTER');

INSERT INTO funcionalidades (nome) VALUES ('MASTER');

INSERT INTO perfis_acesso (funcionalidade_id, visualizar_dados, editar_dados, deletar_dados, criar_dados) VALUES (1, 1, 1, 1, 1);

INSERT INTO acesso_usuario_sistema (nome, id_usuario, id_sistema, perfil_id_sistema, status_acesso) VALUES ("MASTER", 1, 1, 1, 1);