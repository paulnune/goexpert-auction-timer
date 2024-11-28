
# GoExpert Auction Timer ⏳

Projeto do laboratório **"Concorrência com Golang - Leilão"** do treinamento GoExpert (FullCycle). O objetivo deste projeto é adicionar uma nova funcionalidade para que o leilão seja fechado automaticamente após um tempo definido, utilizando **goroutines** para gerenciamento concorrente. Desenvolvido por **Paulo Nunes**.

---

## 🏆 O Desafio

Adicionar uma funcionalidade ao projeto existente para fechamento automático de leilões após um tempo definido.  

### Contexto:
- A rotina de criação de leilão e lances já está implementada.
- O [projeto original](https://github.com/devfullcycle/labs-auction-goexpert) necessita de melhoria para incluir essa funcionalidade.
- A validação de leilão fechado ou aberto durante a criação de novos lances (bids) já está implementada.

---

## 🚀 Funcionalidades

- **Criação de leilão com duração automática:**  
  Configuração do tempo limite do leilão utilizando variáveis de ambiente.
- **Rotina de fechamento automático:**  
  Monitoramento e atualização dos leilões vencidos através de uma goroutine.
- **Testes automatizados:**  
  Cobertura de testes para garantir o correto funcionamento do fechamento automático.

---

## 🛠️ Requisitos

### Linguagens e pacotes utilizados:
- **Go**  
  - `context`  
  - `net/http`  
  - `encoding/json`  
  - `testing`  
  - `testify`

### Infraestrutura:
- **Docker** ou **Podman** e **Docker Compose** configurados no ambiente.

---

## 📝 Como Rodar o Projeto

### Subindo os containers:
```bash
make up
```

### Derrubando os containers:
```bash
make down
```

### Fazendo uma requisição:
```bash
make run
```

---

## ✅ Testes Automatizados

### Propósito
Os testes têm como objetivo validar:
1. A criação de leilões com tempos pré-configurados.
2. O fechamento automático de leilões após o tempo definido.
3. A interação correta entre entidades e bancos de dados.

### Como Executar os Testes
1. Para rodar todos os testes:
   ```bash
   make test
   ```

2. Para gerar um relatório de cobertura:
   ```bash
   make coverage
   ```

3. Para visualizar a cobertura em HTML:
   Após rodar `make coverage`, o relatório estará disponível em `/tmp/cover*/coverage.html`. Abra o arquivo no navegador.

### Evidências de Cobertura
Exemplo de saída ao executar `make coverage`:
```
github.com/user/project/internal/entity/auction_entity  coverage: 85.0% of statements
github.com/user/project/internal/usecase/auction_usecase  coverage: 92.0% of statements
```

Resultado esperado: uma cobertura mínima de 80% nos módulos principais.

---

## 📦 Estrutura do Projeto

```
.
├── cmd
│   └── auction
│       └── main.go
├── configuration
│   ├── database
│   │   └── mongodb
│   │       └── connection.go
│   ├── logger
│   │   └── logger.go
│   └── rest_err
│       └── rest_err.go
├── docker-compose.yml
├── Dockerfile
├── go.mod
├── go.sum
├── internal
│   ├── entity
│   │   ├── auction_entity
│   │   │   └── auction_entity.go
│   │   ├── bid_entity
│   │   │   └── bid_entity.go
│   │   └── user_entity
│   │       └── user_entity.go
│   ├── infra
│   │   ├── api
│   │   │   └── web
│   │   │       ├── controller
│   │   │       │   ├── auction_controller
│   │   │       │   │   ├── create_auction_controller.go
│   │   │       │   │   └── find_auction_controller.go
│   │   │       │   ├── bid_controller
│   │   │       │   │   ├── create_bid_controller.go
│   │   │       │   │   └── find_bid_controller.go
│   │   │       │   └── user_controller
│   │   │       │       └── find_user_controller.go
│   │   │       └── validation
│   │   │           └── validation.go
│   │   └── database
│   │       ├── auction
│   │       │   ├── create_auction.go
│   │       │   └── find_auction.go
│   │       ├── bid
│   │       │   ├── create_bid.go
│   │       │   └── find_bid.go
│   │       └── user
│   │           └── find_user.go
│   ├── internal_error
│   │   └── internal_error.go
│   └── usecase
│       ├── auction_usecase
│       │   ├── create_auction_usecase.go
│       │   └── find_auction_usecase.go
│       ├── bid_usecase
│       │   ├── create_bid_usecase.go
│       │   └── find_bid_usecase.go
│       └── user_usecase
│           └── find_user_usecase.go
├── Makefile
└── README.md
```

---

## 👨‍💻 Autor

**Paulo Henrique Nunes Vanderley**  
- 🌐 [Site Pessoal](https://www.paulonunes.dev/)  
- 🌐 [GitHub](https://github.com/paulnune)  
- ✉️ Email: [paulo.nunes@live.de](mailto:paulo.nunes@live.de)  
- 🚀 Aluno da Pós **GoExpert 2024** pela [FullCycle](https://fullcycle.com.br)

---

## 🎉 Agradecimentos

Este repositório foi desenvolvido como parte do treinamento **GoExpert 2024** da [FullCycle](https://fullcycle.com.br). Agradeço à equipe por proporcionar um conteúdo de altíssima qualidade! 🚀