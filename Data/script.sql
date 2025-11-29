CREATE TABLE recomendations (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    category TEXT NOT NULL,
    embedding vector(1024) NOT NULL
);

CREATE INDEX idx_recomendations ON recomendations USING HNSW (embedding vector_l2_ops);


CREATE TABLE products (
      id SERIAL PRIMARY KEY,
      title TEXT NOT NULL,
      category TEXT NOT NULL,
      summary TEXT NOT NULL,
      description TEXT NOT NULL
);

INSERT INTO products VALUES
(1, 'Café Brasileiro', 'robusto', 'Um dos cafés mais populares do mundo', 
'Café brasileiro é famoso por seus sabores equilibrados e agradáveis. 
A maioria dos grãos brasileiros tende a ter um sabor suave, com notas de chocolate e castanhas. 
Regiões como Minas Gerais produzem cafés com perfil doce e amanteigado, enquanto áreas como a Bahia são conhecidas por notas frutadas e vibrantes.');

INSERT INTO products (id, title, category, summary, description) VALUES
(2, 'Café Colombiano', 'robusto', 
'Conhecido pelo sabor equilibrado, suave e aroma rico', 
'O café colombiano é celebrado por seu perfil de sabor bem equilibrado. 
Normalmente apresenta corpo médio, acidez brilhante e notas de frutas cítricas ou vermelhas. 
A geografia diversa do país permite nuances variadas, como a doçura caramelizada da região de Antioquia e a frutuosidade vibrante de Huila.');

INSERT INTO products VALUES
(3, 'Etíope Yirgacheffe', 'robusto', 
'Um café floral e cítrico com corpo leve', 
'Yirgacheffe é considerado uma joia no mundo do café. 
É um café processado via lavagem, com corpo leve e uma qualidade semelhante ao chá. 
Suas notas de sabor são predominantemente florais, como jasmim e bergamota, com acidez brilhante e cítrica. 
É conhecido por seu caráter delicado e complexo.');

INSERT INTO products VALUES
(4, 'Quênia AA', 'suave', 
'Um café vibrante com notas frutadas e vínicas', 
'O café queniano é altamente valorizado por sua complexidade e sabores vivos. 
A classificação AA indica grãos maiores, geralmente associados a maior qualidade. 
Esse café apresenta acidez brilhante, corpo encorpado e notas que lembram vinho, como groselha, tomate e frutas cítricas.');

INSERT INTO products VALUES
(5, 'Sumatra Mandheling', 'suave', 
'Um café encorpado e terroso da Indonésia', 
'Sumatra Mandheling é famoso pela baixa acidez e corpo denso e licoroso. 
Possui um perfil de sabor único, terroso e rústico, com notas de chocolate, frutas tropicais e um aroma característico de floresta úmida. 
Geralmente é processado via método wet-hulled, que contribui para seu sabor terroso e final suave.');

INSERT INTO products VALUES
(6, 'Costa Rica Tarrazú', 'intenso', 
'Um café limpo, brilhante e equilibrado', 
'O café Tarrazú, cultivado em grandes altitudes na Costa Rica, é conhecido por sua qualidade superior e sabor limpo. 
Possui corpo médio, acidez delicada e brilhante, e final suave. 
Notas comuns incluem açúcar mascavo, frutas cítricas e toques de frutas tropicais.');

INSERT INTO products VALUES
(7, 'Guatemala Antigua', 'suave', 
'Um café encorpado com sabor achocolatado e defumado', 
'O café Antigua é cultivado em uma região vulcânica da Guatemala, o que confere um sabor rico e encorpado. 
Seu perfil inclui notas de chocolate, especiarias e um aroma sutilmente defumado. 
Possui acidez brilhante e final prolongado com toque picante.');

INSERT INTO products VALUES
(8, 'Jamaicano Blue Mountain', 'robusto', 
'Um dos cafés mais raros e caros do mundo', 
'O café Blue Mountain é conhecido por seu sabor suave e ausência de amargor. 
Possui corpo equilibrado, sabor limpo e doce e final extremamente suave. 
É frequentemente descrito com notas de castanhas e ervas. 
É considerado um café de luxo e altíssima qualidade.');

INSERT INTO products VALUES
(9, 'Havaiano Kona', 'intenso', 
'Um café raro e delicado, com sabor suave e brilhante', 
'O café Kona é cultivado nas encostas dos vulcões Mauna Loa e Hualalai no Havaí. 
É um café suave, de corpo leve, com aroma complexo e sabor limpo. 
Notas incluem chocolate ao leite, castanhas e frutas, com baixa acidez e final doce. 
É valorizado por sua raridade e qualidade consistente.');

INSERT INTO products VALUES
(10, 'Robusta Vietnamita', 'intenso', 
'Um café forte, encorpado e com alto teor de cafeína', 
'O café robusta do Vietnã é conhecido por seu sabor intenso e encorpado, sendo essencial na cultura de café vietnamita. 
Apresenta perfil achocolatado e amanteigado, com notas de caramelo e um retrogosto amargo e marcante. 
Costuma ser preparado em filtro phin, resultando em uma bebida espessa, muitas vezes servida com leite condensado.');

INSERT INTO products VALUES
(11, 'Tanzânia Peaberry', 'arábica', 
'Um café vibrante com notas cítricas e frutadas', 
'Tanzânia Peaberry é um tipo raro em que a cereja do café produz um único grão arredondado, concentrando mais sabor. 
Possui corpo médio, acidez brilhante e notas de cítricos, groselha e toques de cedro. 
Entrega uma xícara elegante e brilhante.');

INSERT INTO products VALUES
(12, 'Iêmen Mokha', 'arábica', 
'Um dos cafés mais antigos e históricos do mundo', 
'O café Mokha do Iêmen possui sabor rústico e distinto. 
Tem corpo encorpado e sabor profundo e complexo, com notas de chocolate, frutas e especiarias. 
O processo de secagem em telhados confere um caráter terroso único. 
É conhecido por seu sabor selvagem e história centenária.');

INSERT INTO products VALUES
(13, 'Burundi', 'arábica', 
'Um café doce, floral e com final limpo', 
'O café do Burundi está ganhando destaque por sua excelente qualidade. 
Cultivado em grandes altitudes, possui perfil limpo e brilhante. 
Notas comuns incluem mel floral, cítricos e frutas vermelhas, com acidez delicada e corpo médio.');

INSERT INTO products VALUES
(14, 'Etíope Harrar', 'arábica', 
'Um café frutado, selvagem e com perfil complexo', 
'O café Harrar, da Etiópia, é seco ao sol e apresenta sabor frutado intenso. 
Possui corpo pesado, baixa acidez e sabor descrito como selvagem e complexo. 
Notas incluem mirtilo, cacau e especiarias. 
É um café marcante e naturalmente frutado.');

INSERT INTO products VALUES
(15, 'Indiano Monsooned Malabar', 'intenso', 
'Um café com caráter único, terroso e amendoado', 
'O Monsooned Malabar é típico da Costa de Malabar, na Índia. 
Os grãos são expostos aos ventos de monções, fazendo com que inchem e percam acidez. 
O resultado é um café de baixíssima acidez, corpo pesado e sabor terroso e amendoado, com aroma pungente e característica singular.');
