

Example markup:

<div class="wrapper">
    <header>I'm a 30px tall header</header>
    <main>I'm the main-content filling the void!</main>
    <footer>I'm a 30px tall footer</footer>
</div>
And CSS to accompany it:

.wrapper {
    height: 100vh;
    display: flex;

    /* Direction of the items, can be row or column */
    flex-direction: column;
}

header,
footer {
    height: 30px;
}

main {
    flex: 1;
}


