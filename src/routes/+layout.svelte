<script lang="ts">
	import favicon from '$lib/assets/favicon.svg';

	let { children } = $props();
</script>

<svelte:head>
	<link rel="icon" href={favicon} />
</svelte:head>

{@render children()}

<footer class="site-footer">
	<span>Made with &lt;3 by Nora, Euan, and End</span>
	<a href="https://hackclub.com" target="_blank" rel="noopener noreferrer">hackclub.com</a>
</footer>

<style>
	.site-footer {
		font-family: 'Departure Mono', monospace;
		display: flex;
		justify-content: center;
		align-items: center;
		gap: 1.5rem;
		padding: 1.5rem 2rem;
		font-size: 0.9rem;
		color: #666;
		border-top: 1px solid #ddd;
		margin-top: 2rem;
	}

	.site-footer a {
		color: #ec3750;
		text-decoration: none;
		font-weight: bold;
	}

	.site-footer a:hover {
		text-decoration: underline;
	}
</style>
