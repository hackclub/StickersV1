<script>
    import Navbar from "../components/Navbar.svelte";
    import Background from "../components/Background.svelte";
    import LazyImage from "../components/LazyImage.svelte";

    let { designs: initialDesigns = [], auth } = $props();

    let designs = $state(initialDesigns);
    let votingId = $state(null);

    async function toggleVote(design) {
        if (votingId) return;
        votingId = design.id;

        try {
            const res = await fetch(`/api/designs/${design.id}/vote`, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
            });
            if (!res.ok) throw new Error("Failed to submit vote");
            const result = await res.json();

            designs = designs.map((d) =>
                d.id === design.id
                    ? { ...d, votes: result.votes, voted: result.voted }
                    : d,
            );
        } catch (e) {
            alert(
                "Error: " + (e instanceof Error ? e.message : "Unknown error"),
            );
        } finally {
            votingId = null;
        }
    }

    const myVotesCount = $derived(designs.filter((d) => d.voted).length);
</script>

<Background />
<Navbar active="vote" />

<main class="page-content">
    <h1><mark>Vote</mark></h1>

    <div class="content-row">
        <div class="card info-card">
            <p>
                Vote for your favorite designs with a click, The highest voted
                design will be included in the monthly sticker box and all will be
                added to the shop for artists to earn commission.
            </p>
        </div>

        <div class="card votes-card">
            <span class="votes-count">Your votes: {myVotesCount}</span>
        </div>
    </div>

    {#if designs.length === 0}
        <div class="empty-state">
            <p>No approved designs to vote on yet.</p>
        </div>
    {:else}
        <div class="designs-grid">
            {#each designs as design}
                <button
                    class="design-card"
                    class:voted={design.voted}
                    class:voting={votingId === design.id}
                    onclick={() => toggleVote(design)}
                    disabled={votingId !== null}
                >
                    <div class="design-image">
                        <LazyImage src={design.cdn_url} alt={design.name} />
                    </div>
                    <div class="design-footer">
                        <span class="design-name">{design.name || "Untitled"}</span>
                        <span class="design-votes"
                            >{design.votes} vote{design.votes !== 1
                                ? "s"
                                : ""}</span
                        >
                    </div>
                    {#if votingId === design.id}
                        <div class="voting-overlay">...</div>
                    {/if}
                </button>
            {/each}
        </div>
    {/if}
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

    .content-row {
        display: flex;
        gap: 1.5rem;
        flex-wrap: nowrap;
        align-items: stretch;
        margin-bottom: 2rem;
    }

    .card {
        background: rgba(255, 255, 255, 0.95);
        padding: 1.5rem;
        border-radius: 0.5rem;
        border: 2px solid #333;
    }

    .info-card {
        flex: 1 1 auto;
    }

    .info-card p {
        font-size: 1.5rem;
        margin: 0;
    }

    .votes-card {
        display: flex;
        align-items: center;
        flex: 0 0 auto;
    }

    .votes-count {
        font-size: 1.25rem;
        white-space: nowrap;
    }

    mark {
        background-color: #d9c9b6;
        padding: 0 0.2rem;
    }

    .empty-state {
        text-align: center;
        padding: 3rem;
        background: rgba(255, 255, 255, 0.95);
        border: 2px solid #333;
        border-radius: 0.5rem;
        font-size: 1.25rem;
    }

    .designs-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
        gap: 1.5rem;
    }

    .design-card {
        background: rgba(255, 255, 255, 0.95);
        border: 3px solid #333;
        border-radius: 0.5rem;
        overflow: hidden;
        cursor: pointer;
        transition:
            transform 0.2s,
            box-shadow 0.2s,
            border-color 0.2s;
        position: relative;
        padding: 0;
        text-align: left;
        font-family: inherit;
    }

    .design-card:hover:not(:disabled) {
        transform: translateY(-4px);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    }

    .design-card.voted {
        border-color: #28a745;
        background: rgba(200, 247, 197, 0.95);
    }

    .design-card.voting {
        opacity: 0.7;
    }

    .design-card:disabled {
        cursor: wait;
    }

    .design-image {
        width: 100%;
        height: 200px;
        display: flex;
        align-items: center;
        justify-content: center;
        background: #f5f5f5;
        padding: 1rem;
    }

    .design-image img {
        max-width: 100%;
        max-height: 100%;
        object-fit: contain;
    }

    .design-footer {
        padding: 1rem;
        border-top: 1px solid #333;
        display: flex;
        flex-direction: column;
        gap: 0.25rem;
    }

    .design-name {
        font-size: 1.25rem;
        font-weight: bold;
    }

    .design-votes {
        font-size: 0.9rem;
        color: #666;
    }

    .voting-overlay {
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: rgba(255, 255, 255, 0.5);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 2rem;
    }

    @media (max-width: 768px) {
        h1 {
            font-size: 2rem;
        }

        .content-row {
            flex-direction: column;
        }

        .info-card {
            flex: 0 0 auto;
        }

        .info-card p {
            font-size: 1rem;
        }

        .card {
            padding: 1rem;
        }

        .votes-count {
            font-size: 1rem;
        }

        .designs-grid {
            grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
            gap: 1rem;
        }

        .design-image {
            height: 150px;
        }

        .design-name {
            font-size: 1rem;
        }

        .design-footer {
            padding: 0.75rem;
        }
    }
</style>
