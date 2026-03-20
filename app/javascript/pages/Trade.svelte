<script>
    import Navbar from "../components/Navbar.svelte";
    import Background from "../components/Background.svelte";

    let { auth } = $props();

    let showModal = $state(false);

    function openMakeDeal() {
        showModal = true;
    }

    function closeModal() {
        showModal = false;
    }

    $effect(() => {
        if (showModal) {
            document.body.style.overflow = "hidden";
        } else {
            document.body.style.overflow = "auto";
        }
    });
</script>

<Background />
<Navbar active="trade" />

<main class="page-content">
    <h1><mark>Trade</mark></h1>

    <button class="make-deal-btn" onclick={openMakeDeal}>Propose</button>

    <h2>
        <div class="section-header">Incoming Trades</div>
    </h2>

    <div class="trades-list">
        <p class="empty-state">No incoming trades yet.</p>
    </div>

    <p class="construction-notice">
        Trading is under construction. Check back soon!
    </p>
</main>

{#if showModal}
    <div class="modal-overlay" onclick={closeModal}>
        <div class="modal" onclick={(e) => e.stopPropagation()}>
            <h2>Propose a Trade</h2>
            <div class="modal-content">
                <div class="trade-side give-side">
                    <label for="give-sticker">You Give:</label>
                    <select id="give-sticker">
                        <option value="">Select a sticker...</option>
                    </select>
                    <input type="number" placeholder="Quantity" min="1" value="1" />
                </div>
                <div class="trade-side get-side">
                    <label for="get-sticker">You Get:</label>
                    <select id="get-sticker">
                        <option value="">Select a sticker...</option>
                    </select>
                    <input type="number" placeholder="Quantity" min="1" value="1" />
                </div>
            </div>
            <div class="modal-actions">
                <button class="cancel-btn" onclick={closeModal}>Cancel</button>
                <button class="submit-btn">Submit Trade</button>
            </div>
        </div>
    </div>
{/if}

<style>
    .page-content {
        padding: 1rem 2rem 2rem;
        font-family: "Departure Mono", monospace;
    }

    h1 {
        font-size: 3rem;
        margin: 0 0 2rem 0;
    }

    h2 {
        font-size: 1.5rem;
        margin: 2rem 0 1rem 0;
    }

    mark {
        background-color: #d9c9b6;
        padding: 0 0.2rem;
    }

    .section-header {
        font-weight: bold;
        background-color: #d9c9b6;
        padding: 0 1rem;
        font-family: "Departure Mono", monospace;
        height: 2rem;
        width: max-content;
        display: flex;
        align-items: center;
    }

    .make-deal-btn {
        background: #444;
        color: white;
        border: 2px solid #333;
        border-radius: 0.5rem;
        padding: 0.75rem 1.5rem;
        font-size: 1.1rem;
        cursor: pointer;
        font-family: inherit;
    }

    .make-deal-btn:hover {
        background: #555;
    }

    .trades-list {
        display: flex;
        flex-direction: column;
        gap: 1rem;
        margin-top: 1rem;
    }

    .empty-state {
        text-align: center;
        padding: 2rem;
        background: rgba(255, 255, 255, 0.95);
        border: 2px solid #333;
        border-radius: 0.5rem;
        color: #666;
        font-size: 1.25rem;
    }

    .construction-notice {
        text-align: center;
        padding: 2rem;
        margin-top: 2rem;
        background: rgba(217, 201, 182, 0.5);
        border: 2px dashed #333;
        border-radius: 0.5rem;
        font-size: 1.25rem;
        color: #666;
    }

    .modal-overlay {
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: rgba(0, 0, 0, 0.5);
        display: flex;
        align-items: center;
        justify-content: center;
        z-index: 1000;
    }

    .modal {
        background: white;
        border: 2px solid #333;
        border-radius: 0.5rem;
        padding: 2rem;
        max-width: 500px;
        width: 90%;
    }

    .modal h2 {
        margin: 0 0 1.5rem 0;
    }

    .modal-content {
        display: flex;
        align-items: stretch;
        gap: 0;
        border: 2px solid #333;
        border-radius: 0.5rem;
        overflow: hidden;
    }

    .trade-side {
        flex: 1;
        padding: 1.5rem;
        display: flex;
        flex-direction: column;
        gap: 0.5rem;
    }

    .give-side {
        background: #ffebee;
    }

    .get-side {
        background: #e8f5e9;
    }

    .trade-side label {
        font-weight: bold;
        margin-bottom: 0.5rem;
    }

    .trade-side select,
    .trade-side input {
        width: 100%;
        padding: 0.5rem;
        border: 1px solid #ccc;
        border-radius: 0.25rem;
        font-family: inherit;
        font-size: 1rem;
    }

    .trade-side input {
        margin-top: 0.5rem;
        width: 80px;
    }

    .modal-actions {
        display: flex;
        gap: 1rem;
        margin-top: 1.5rem;
        justify-content: flex-end;
    }

    .cancel-btn {
        background: #eee;
        color: #333;
        border: 2px solid #333;
        border-radius: 0.5rem;
        padding: 0.75rem 1.25rem;
        font-size: 1rem;
        cursor: pointer;
        font-family: inherit;
    }

    .submit-btn {
        background: #4caf50;
        color: white;
        border: 2px solid #333;
        border-radius: 0.5rem;
        padding: 0.75rem 1.25rem;
        font-size: 1rem;
        cursor: pointer;
        font-family: inherit;
    }

    .cancel-btn:hover {
        background: #ddd;
    }

    .submit-btn:hover {
        background: #45a049;
    }
</style>
