'''Tipos de dados SQL 
#Int Números inteiros'''

CREATE TABLE produtos (
    id INT PRIMARY KEY,
    quantidade_estoque INT NOT NULL
);

CREATE TABLE pedidos (
    id INT PRIMARY KEY,
    valor_total DECIMAL(10,2) -- 10 dígitos, 2 casas decimais
);
CREATE TABLE medicamentos (
    id INT PRIMARY KEY,
    dosagem FLOAT
);

''' Tipos de String - Texto de tamanho variável'''

CREATE TABLE clientes (
    id INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(255)
);

CREATE TABLE usuarios (
    id INT PRIMARY KEY,
    codigo_acesso CHAR(6) -- Sempre 6 caracteres
);

CREATE TABLE artigos (
    id INT PRIMARY KEY,
    conteudo TEXT
);

'''Tipos Data e Hora - apenas data'''
CREATE TABLE eventos (
    id INT PRIMARY KEY,
    data_evento DATE NOT NULL
);
CREATE TABLE logs (
    id INT PRIMARY KEY,
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE horarios (
    id INT PRIMARY KEY,
    hora_inicio TIME
);

'''Outros Tipos
BOOLEAN - Valores verdadeiro/falso'''

CREATE TABLE tarefas (
    id INT PRIMARY KEY,
    concluida BOOLEAN DEFAULT FALSE
);

CREATE TABLE arquivos (
    id INT PRIMARY KEY,
    conteudo BLOB
);

'''Integridade da Entidade
Garante que cada registro seja único e identificável.'''

CREATE TABLE alunos (
    matricula INT PRIMARY KEY,          -- Chave primária
    nome VARCHAR(100) NOT NULL,         -- Não pode ser nulo
    cpf VARCHAR(11) UNIQUE NOT NULL     -- Único e não nulo
);

'''Integridade Referencial
Mantém a consistência entre relações de tabelas.

Exemplo:'''
CREATE TABLE departamentos (
    id INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE funcionarios (
    id INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    departamento_id INT,
    FOREIGN KEY (departamento_id) REFERENCES departamentos(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

'''Integridade da Chave
Define regras para chaves primárias e estrangeiras.

Exemplo:'''
CREATE TABLE pedidos (
    id INT PRIMARY KEY,
    cliente_id INT NOT NULL,
    data_pedido DATE NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

'''Exemplo Prático: Sistema Acadêmico'''
-- Tabela de Cursos
CREATE TABLE cursos (
    codigo_curso INT PRIMARY KEY,
    nome_curso VARCHAR(100) NOT NULL UNIQUE,
    duracao_semestres INT CHECK (duracao_semestres > 0),
    ativo BOOLEAN DEFAULT TRUE
);

-- Tabela de Professores
CREATE TABLE professores (
    id_professor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    especialidade VARCHAR(100),
    data_contratacao DATE NOT NULL,
    salario DECIMAL(10,2) CHECK (salario > 0)
);

-- Tabela de Disciplinas
CREATE TABLE disciplinas (
    codigo_disciplina VARCHAR(10) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    creditos INT NOT NULL CHECK (creditos BETWEEN 1 AND 6),
    curso_id INT NOT NULL,
    professor_id INT NOT NULL,
    FOREIGN KEY (curso_id) REFERENCES cursos(codigo_curso),
    FOREIGN KEY (professor_id) REFERENCES professores(id_professor)
);

-- Tabela de Alunos
CREATE TABLE alunos (
    matricula INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE,
    data_nascimento DATE NOT NULL,
    curso_id INT NOT NULL,
    FOREIGN KEY (curso_id) REFERENCES cursos(codigo_curso)
);

-- Tabela de Matrículas
CREATE TABLE matriculas (
    id_matricula INT PRIMARY KEY AUTO_INCREMENT,
    aluno_matricula INT NOT NULL,
    disciplina_codigo VARCHAR(10) NOT NULL,
    semestre VARCHAR(6) NOT NULL,
    nota_final DECIMAL(4,2) CHECK (nota_final BETWEEN 0 AND 10),
    situacao ENUM('aprovado', 'reprovado', 'cursando'),
    FOREIGN KEY (aluno_matricula) REFERENCES alunos(matricula),
    FOREIGN KEY (disciplina_codigo) REFERENCES disciplinas(codigo_disciplina),
    UNIQUE KEY unique_matricula (aluno_matricula, disciplina_codigo, semestre)
);

'''Inserindo Dados de Exemplo'''

-- Inserindo cursos
INSERT INTO cursos VALUES 
(1, 'Ciência da Computação', 8, TRUE),
(2, 'Engenharia de Software', 8, TRUE);

-- Inserindo professores
INSERT INTO professores (nome, especialidade, data_contratacao, salario) VALUES 
('Dr. Silva', 'Banco de Dados', '2020-03-15', 8500.00),
('Dra. Santos', 'Inteligência Artificial', '2019-08-01', 9200.00);

-- Inserindo disciplinas
INSERT INTO disciplinas VALUES 
('CC001', 'Banco de Dados I', 4, 1, 1),
('CC002', 'Programação Avançada', 6, 1, 2);

-- Inserindo alunos
INSERT INTO alunos VALUES 
(2023001, 'João Pereira', 'joao@email.com', '2000-05-15', 1),
(2023002, 'Maria Silva', 'maria@email.com', '2001-08-22', 1);
