function fadeCardsIn() {
    const window_top = $(window).scrollTop()
    const window_bottom = $(window).scrollTop() + $(window).innerHeight()

    console.log(`Viewport: ${window_top} to ${window_bottom}.`)

    var cards = $(".card")
    var count = 0

    cards.each(function() {
        count += 1
        const card = $(this)

        const card_top = card.offset().top;
        const card_bottom = card.offset().top + card.outerHeight()

        // If our card is in the range of the window viewport.
        if ((window_bottom > card_top) && (window_top < card_bottom)) {
            card.fadeTo(1000, 1, "swing")
            console.log(`Showing card ${count}.`)
        } else {
            card.fadeTo(1000, 0, "swing")
        }

        // if (bottomOfCurrentView > cardDistanceToTop) {
        //     card.fadeTo('slow', 1, "swing");
        //     console.log(`Fading in card ${count}.`)
        // } else {
        //     card.fadeTo('slow', 0, "swing");
        // }
    })
}

$(document).ready(fadeCardsIn)
$(window).scroll(fadeCardsIn)