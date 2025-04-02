<template>
  <div id="app">
    <h1>Busca de Operadoras</h1>
    <input v-model="query" placeholder="Digite o nome da operadora" />
    <button @click="buscarOperadoras">Buscar</button>
    
    <ul>
      <li v-for="operadora in operadoras" :key="operadora.id">
        {{ operadora.nome }} <!-- Altere "nome" pelo campo correto do seu CSV -->
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  data() {
    return {
      query: '',
      operadoras: [],
    };
  },
  methods: {
    async buscarOperadoras() {
      const response = await fetch(`http://localhost:8000/buscar-operadoras?query=${this.query}`);
      this.operadoras = await response.json();
    },
  },
};
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
