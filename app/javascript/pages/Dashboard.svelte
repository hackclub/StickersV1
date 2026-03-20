<script>
    import Navbar from "../components/Navbar.svelte";
    import Background from "../components/Background.svelte";
    // import Peelable from "../components/Peelable.svelte";
    // import stickersBg from "../assets/images/stickers.jpg";

    let { auth } = $props();

    // function goToTrade() {
    //     window.location.href = "/trade";
    // }

    // function goToEarn() {
    //     window.location.href = "/shop";
    // }

    // function goToVote() {
    //     window.location.href = "/vote";
    // }

    // function goToStickers() {
    //     window.location.href = "/stickers";
    // }
</script>

<Background />
<Navbar active="dash" {auth} />

<main class="page-content">
    <h1><mark>Dashboard</mark></h1>

    <div class="construction-card">
        <div class="construction-icon">🚧</div>
        <h2>Under Construction</h2>
        <p>
            Your personal sticker dashboard is being built! Soon you'll be able
            to manage your collection, track trades, and more.
        </p>
        <p class="hint">Check back later for updates.</p>
    </div>
</main>

<!-- ORIGINAL DASHBOARD - COMMENTED OUT FOR NOW
<main class="page-content">
    <div class="layout">
        <div class="left-column">
            <h1><mark>What's new</mark></h1>

            <div class="cards">
                <div class="card">
                    <p>
                        USER is looking for a sticker that you own! Are you open
                        to trade?
                    </p>
                    <Peelable
                        class="btn-sticker"
                        corner="bottom-right"
                        peelOnHover={true}
                        hoverPeelAmount={0.3}
                        peelOnClick={true}
                        onPeelComplete={goToTrade}
                        borderRadius="0.5rem"
                    >
                        {#snippet topContent()}
                            <div class="sticker-btn">Trade</div>
                        {/snippet}
                        {#snippet backContent()}
                            <div class="sticker-back"></div>
                        {/snippet}
                        {#snippet bottomContent()}
                            <div class="sticker-surface"></div>
                        {/snippet}
                    </Peelable>
                </div>

                <div class="card">
                    <p>STICKER is X% cheaper this week</p>
                    <Peelable
                        class="btn-sticker"
                        corner="bottom-right"
                        peelOnHover={true}
                        hoverPeelAmount={0.3}
                        peelOnClick={true}
                        onPeelComplete={goToEarn}
                        borderRadius="0.5rem"
                    >
                        {#snippet topContent()}
                            <div class="sticker-btn">Shop</div>
                        {/snippet}
                        {#snippet backContent()}
                            <div class="sticker-back"></div>
                        {/snippet}
                        {#snippet bottomContent()}
                            <div class="sticker-surface"></div>
                        {/snippet}
                    </Peelable>
                </div>

                <div class="card">
                    <p>New sticker drop! Vote on the best option now!</p>
                    <Peelable
                        class="btn-sticker"
                        corner="bottom-right"
                        peelOnHover={true}
                        hoverPeelAmount={0.3}
                        peelOnClick={true}
                        onPeelComplete={goToVote}
                        borderRadius="0.5rem"
                    >
                        {#snippet topContent()}
                            <div class="sticker-btn">Vote</div>
                        {/snippet}
                        {#snippet backContent()}
                            <div class="sticker-back"></div>
                        {/snippet}
                        {#snippet bottomContent()}
                            <div class="sticker-surface"></div>
                        {/snippet}
                    </Peelable>
                </div>
            </div>
        </div>

        <div class="divider"></div>

        <div class="right-column">
            <div class="right-header">
                <h1><mark>Your collection</mark></h1>
                <div class="button-group">
                    <button class="btn-left" onclick={goToStickers}
                        >Claim stickers</button
                    >
                    <button class="btn-right">Place stickers</button>
                </div>
            </div>
            <div class="canvas" style="background-image: url({stickersBg});">
                <div class="empty-overlay">
                    <b><u>No stickers placed!</u></b><br />X stickers owned.
                </div>
            </div>
        </div>
    </div>
</main>
-->

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

    /* ORIGINAL STYLES - KEPT FOR WHEN DASHBOARD IS READY
    .layout {
        display: flex;
        gap: 2rem;
        height: calc(100vh - 120px);
        overflow: hidden;
        width: 100%;
        box-sizing: border-box;
    }

    .left-column {
        flex: 0 0 350px;
        overflow: hidden;
        padding-bottom: 2rem;
        display: flex;
        flex-direction: column;
    }

    .cards {
        display: flex;
        flex-direction: column;
        overflow-x: hidden;
        overflow-y: auto;
        flex: 1;
        padding: 1rem;
        border: 2px solid #333;
        border-radius: 0.5rem;
        background: rgba(255, 255, 255, 0.3);
    }

    .divider {
        width: 2px;
        background: #333;
        flex-shrink: 0;
        margin-bottom: 2rem;
    }

    .right-column {
        flex: 1 1 auto;
        display: flex;
        flex-direction: column;
        min-width: 0;
        padding-bottom: 2rem;
        overflow: hidden;
    }

    .canvas {
        flex: 1;
        background-color: rgba(255, 255, 255, 0.95);
        background-size: 100% 100%;
        background-repeat: no-repeat;
        background-position: center;
        border: 2px solid #333;
        border-radius: 0.5rem;
        overflow-y: auto;
        overscroll-behavior: contain;
        position: relative;
    }

    .empty-overlay {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        font-size: 2rem;
        text-align: center;
    }

    .empty-overlay mark {
        background-color: #d9c9b6;
        padding: 0.5rem 1rem;
    }

    .right-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 1rem;
        margin-bottom: 1rem;
        flex-shrink: 0;
    }

    .right-header h1 {
        margin: 0;
    }

    .card {
        background: rgba(250, 248, 245, 0.95);
        padding: 1.5rem;
        border-radius: 0.5rem;
        border: 2px solid #333;
        margin-bottom: 1.5rem;
    }

    p {
        font-size: 1.5rem;
        margin: 0 0 1rem 0;
        font-family: "Departure Mono", monospace;
    }

    :global(.btn-sticker) {
        width: 180px;
        height: 50px;
        cursor: pointer;
        font-family: "Departure Mono", monospace;
    }

    .sticker-btn {
        width: 100%;
        height: 100%;
        background: #8bb1e3;
        border-radius: 0.5rem;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 1.4rem;
    }

    .sticker-back {
        width: 100%;
        height: 100%;
        background: #729abd;
        border-radius: 0.5rem;
    }

    .sticker-surface {
        width: 100%;
        height: 100%;
        background: #d9c9b6;
        border-radius: 0.5rem;
    }

    @media (max-width: 1400px) {
        .layout {
            flex-direction: column;
            height: auto;
            overflow: visible;
        }

        .left-column {
            flex: 0 0 auto;
            min-width: 0;
            max-width: 100%;
            overflow: visible;
        }

        .right-column {
            padding-bottom: 2rem;
            max-width: 100%;
            min-width: 0;
        }

        .divider {
            width: 100%;
            height: 2px;
            margin: 1rem 0;
        }

        .canvas {
            min-height: 50vh;
            height: auto;
        }
    }

    .button-group {
        display: flex;
    }

    .button-group button {
        background: #444;
        color: white;
        border: 2px solid #333;
        padding: 0.75rem 1.25rem;
        font-size: 1rem;
        cursor: pointer;
        font-family: inherit;
    }

    .button-group button:hover {
        background: #555;
    }

    .btn-left {
        border-radius: 0.5rem 0 0 0.5rem;
        border-right: 1px solid #333;
    }

    .btn-right {
        border-radius: 0 0.5rem 0.5rem 0;
        border-left: 1px solid #333;
    }
    */
</style>
