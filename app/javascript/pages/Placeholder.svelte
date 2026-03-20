<script>
    import Navbar from "../components/Navbar.svelte";
    import Background from "../components/Background.svelte";

    let { page = "", auth } = $props();
</script>

<Background />
<Navbar active={page} />

<main class="page-content">
    <h1><mark>{page}</mark></h1>
    <div class="placeholder-card">
        <p>Coming soon...</p>
    </div>
</main>

<style>
    .page-content {
        padding: 1rem 2rem 2rem;
        font-family: "Departure Mono", monospace;
    }

    h1 {
        font-size: 3rem;
        margin: 0 0 2rem 0;
        text-transform: capitalize;
    }

    mark {
        background-color: #d9c9b6;
        padding: 0 0.2rem;
    }

    .placeholder-card {
        background: rgba(255, 255, 255, 0.95);
        padding: 3rem;
        border-radius: 0.5rem;
        border: 2px solid #333;
        text-align: center;
    }

    p {
        font-size: 1.5rem;
        margin: 0;
        color: #666;
    }
</style>
