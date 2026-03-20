<script>
    import Navbar from "../components/Navbar.svelte";
    import Background from "../components/Background.svelte";

    /** @type {{ designs: Array<{ id: string, name: string, image?: string, in_stock?: number, price?: number, program?: string, created?: string, artist?: string }>, auth: { user: any, logged_in: boolean } }} */
    let { designs = [], auth } = $props();

    let selectedRarity = $state("all");
    let searchQuery = $state("");
    let showUploadModal = $state(false);

    const filteredDesigns = $derived(
        designs.filter((d) => {
            const matchesSearch =
                searchQuery === "" ||
                d.name?.toLowerCase().includes(searchQuery.toLowerCase());

            // For now, just return all that match search
            // Rarity filter can be implemented when data has rarity field
            return matchesSearch;
        }),
    );

    function openUploadModal() {
        showUploadModal = true;
    }

    function closeUploadModal() {
        showUploadModal = false;
    }
</script>

<Background />
<Navbar active="designs" />

<main class="page-content">
    <h1><mark>Designs</mark></h1>

    <div class="content-row">
        <div class="card info-card">
            <p>Check out all the Hack Club stickers, let us know if we missed any!</p>
        </div>

        <div class="card filter-card">
            <label for="rarity">Sort:</label>
            <select id="rarity" bind:value={selectedRarity}>
                <option value="all">All</option>
                <option value="rarity">Rarity</option>
                <option value="current">Available</option>
                <option value="old">Old</option>
                <option value="special">Special</option>
                <option value="in-person">In-Person</option>
            </select>
        </div>

        <div class="card search-card">
            <input
                type="text"
                placeholder="Search designs..."
                bind:value={searchQuery}
            />
        </div>

        <button class="card upload-btn" onclick={openUploadModal}>+ Upload a design</button>
    </div>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Design</th>
                    <th>Name</th>
                    <th>In Stock</th>
                    <th>Price</th>
                    <th>Program</th>
                    <th>Created</th>
                    <th>Artist</th>
                </tr>
            </thead>
            <tbody>
                {#each filteredDesigns as design}
                    <tr>
                        <td class="design-icon">
                            {#if design.image}
                                <img src={design.image} alt={design.name} class="design-thumb" />
                            {:else}
                                -
                            {/if}
                        </td>
                        <td>{design.name || "-"}</td>
                        <td class:out-of-stock={design.in_stock === 0}>{design.in_stock ?? "-"}</td>
                        <td>{design.price ? `${design.price} hrs` : "-"}</td>
                        <td>{design.program || "-"}</td>
                        <td>{design.created || "-"}</td>
                        <td>{design.artist || "-"}</td>
                    </tr>
                {:else}
                    <tr>
                        <td colspan="7" class="empty-row">No designs found</td>
                    </tr>
                {/each}
            </tbody>
        </table>
    </div>
</main>

{#if showUploadModal}
    <div class="modal-overlay" onclick={closeUploadModal}>
        <div class="modal" onclick={(e) => e.stopPropagation()}>
            <h2>Upload a Design</h2>
            <p class="modal-info">
                Submit your sticker design for review. Approved designs may be included in future sticker drops!
            </p>
            <form class="upload-form">
                <div class="form-group">
                    <label for="design-name">Design Name</label>
                    <input type="text" id="design-name" placeholder="My Awesome Sticker" />
                </div>
                <div class="form-group">
                    <label for="design-url">Image URL</label>
                    <input type="url" id="design-url" placeholder="https://..." />
                </div>
                <div class="form-group">
                    <label for="design-description">Description (optional)</label>
                    <textarea id="design-description" placeholder="Tell us about your design..."></textarea>
                </div>
                <div class="modal-actions">
                    <button type="button" class="cancel-btn" onclick={closeUploadModal}>Cancel</button>
                    <button type="submit" class="submit-btn">Submit Design</button>
                </div>
            </form>
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

    .content-row {
        display: flex;
        gap: 1.5rem;
        flex-wrap: wrap;
        align-items: stretch;
    }

    .card {
        background: rgba(255, 255, 255, 0.95);
        padding: 1.5rem;
        border-radius: 0.5rem;
        border: 2px solid #333;
    }

    .info-card {
        flex: 0 0 auto;
    }

    .filter-card {
        display: flex;
        align-items: center;
        gap: 0.75rem;
        flex: 0 0 auto;
    }

    .filter-card label {
        font-size: 1.25rem;
        white-space: nowrap;
    }

    .filter-card select {
        font-family: inherit;
        font-size: 1rem;
        padding: 0.5rem 1rem;
        border: 2px solid #333;
        border-radius: 0.5rem;
        background: rgba(250, 248, 245, 0.95);
        cursor: pointer;
    }

    .search-card {
        flex: 1;
        display: flex;
        align-items: center;
    }

    .search-card input {
        font-family: inherit;
        font-size: 1rem;
        padding: 0.5rem 1rem;
        border: 2px solid #333;
        border-radius: 0.5rem;
        background: rgba(250, 248, 245, 0.95);
        width: 100%;
    }

    .upload-btn {
        font-family: "Departure Mono", monospace;
        font-size: 1.5rem;
        cursor: pointer;
        white-space: nowrap;
        flex: 0 0 auto;
    }

    .upload-btn:hover {
        background: rgba(250, 248, 245, 1);
    }

    p {
        font-size: 1.5rem;
        margin: 0;
        white-space: nowrap;
    }

    mark {
        background-color: #d9c9b6;
        padding: 0 0.2rem;
    }

    .table-container {
        margin-top: 2rem;
        background: rgba(255, 255, 255, 0.95);
        border: 2px solid #333;
        border-radius: 0.5rem;
        overflow: hidden;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        font-size: 1.1rem;
    }

    th,
    td {
        padding: 1rem;
        text-align: left;
        border-bottom: 1px solid #333;
    }

    th {
        background: rgba(217, 201, 182, 0.5);
        font-weight: normal;
    }

    tr:last-child td {
        border-bottom: none;
    }

    tbody tr:hover {
        background: rgba(250, 248, 245, 0.5);
    }

    .design-icon {
        font-size: 2rem;
    }

    .design-thumb {
        width: 50px;
        height: 50px;
        object-fit: contain;
    }

    .out-of-stock {
        color: #cc0000;
    }

    .empty-row {
        text-align: center;
        color: #666;
        padding: 2rem !important;
    }

    @media (max-width: 768px) {
        h1 {
            font-size: 2rem;
        }

        .content-row {
            flex-direction: column;
        }

        p {
            font-size: 1rem;
            white-space: normal;
        }

        .card {
            padding: 1rem;
        }

        .filter-card label {
            font-size: 1rem;
        }

        .upload-btn {
            font-size: 1.1rem;
            width: 100%;
        }

        .table-container {
            overflow-x: auto;
        }

        table {
            font-size: 0.85rem;
            min-width: 600px;
        }

        th,
        td {
            padding: 0.5rem;
        }
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
        margin: 0 0 1rem 0;
        font-size: 1.75rem;
    }

    .modal-info {
        font-size: 1rem !important;
        white-space: normal !important;
        color: #666;
        margin-bottom: 1.5rem !important;
    }

    .upload-form {
        display: flex;
        flex-direction: column;
        gap: 1rem;
    }

    .form-group {
        display: flex;
        flex-direction: column;
        gap: 0.5rem;
    }

    .form-group label {
        font-weight: bold;
        font-size: 1rem;
    }

    .form-group input,
    .form-group textarea {
        font-family: inherit;
        font-size: 1rem;
        padding: 0.75rem;
        border: 2px solid #333;
        border-radius: 0.5rem;
        background: rgba(250, 248, 245, 0.95);
    }

    .form-group textarea {
        min-height: 100px;
        resize: vertical;
    }

    .modal-actions {
        display: flex;
        gap: 1rem;
        margin-top: 1rem;
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
