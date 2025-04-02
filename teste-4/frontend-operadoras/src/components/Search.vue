<template>
  <div class="container">
    <h2>Buscar Operadoras</h2>
    <input v-model="query" placeholder="Digite o nome ou CNPJ" @keyup.enter="buscarOperadoras" />
    <button @click="buscarOperadoras">Buscar</button>

    <div v-if="operadoras.length">
      <h3>Resultados:</h3>
      <ul>
        <li v-for="operadora in operadoras" :key="operadora.registro_ans">
          <strong>{{ operadora.nome_fantasia || operadora.razao_social }}</strong> - CNPJ: {{ operadora.cnpj }}
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      query: "",
      operadoras: [],
    };
  },
  methods: {
    async buscarOperadoras() {
      if (!this.query) return;

      try {
        const response = await axios.get(`http://127.0.0.1:5000/buscar?query=${this.query}`);
        this.operadoras = response.data;
      } catch (error) {
        console.error("Erro ao buscar operadoras:", error);
      }
    },
  },
};
</script>

<style scoped>
.container {
  max-width: 600px;
  margin: auto;
  text-align: center;
}
input {
  width: 80%;
  padding: 8px;
  margin: 10px 0;
}
button {
  padding: 8px 12px;
  cursor: pointer;
}
</style>
