<script>
    import Navbar from "../components/Navbar.svelte";
    import Background from "../components/Background.svelte";

    let { auth } = $props();
</script>

<Background />
<Navbar active="shop" {auth} />

<main class="page-content">
    <h1><mark>Shop</mark></h1>

    <div class="construction-card">
        <div class="construction-icon">🚧</div>
        <h2>Under Construction</h2>
        <p>
            The sticker shop is currently being built! Soon you'll be able to 
            spend your stickets on exclusive stickers.
        </p>
        <p class="hint">
            Check back later for updates.
        </p>
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
    }

    mark {
        background-color: #d9c9b6;
        padding: 0 0.2rem;
    }

    .construction-card {
        background: rgba(255, 255, 255, 0.95);
        padding: 3rem;
        border-radius: 0.5rem;
        border: 2px solid #333;
        text-align: center;
        max-width: 600px;
    }

    .construction-icon {
        font-size: 4rem;
        margin-bottom: 1rem;
    }

    .construction-card h2 {
        font-size: 2rem;
        margin: 0 0 1.5rem 0;
    }

    .construction-card p {
        font-size: 1.25rem;
        margin: 0 0 1rem 0;
        line-height: 1.6;
    }

    .hint {
        color: #666;
        font-size: 1rem !important;
    }

    @media (max-width: 768px) {
        h1 {
            font-size: 2rem;
        }

        .construction-card {
            padding: 2rem;
        }

        .construction-card h2 {
            font-size: 1.5rem;
        }

        .construction-card p {
            font-size: 1rem;
        }

        .construction-icon {
            font-size: 3rem;
        }
    }
</style>
