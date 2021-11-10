
// Animation function.
// Grab all .card classes on page and reveal as they come into view.
function fadeCardsIn() {
    const window_top = $(window).scrollTop()
    const window_bottom = $(window).scrollTop() + $(window).innerHeight()
    const cards = $(".card")

    cards.each(function() {
        const card = $(this)

        const card_top = card.offset().top;
        const card_bottom = card.offset().top + card.outerHeight()

        // If our card is in the range of the window viewport.
        if ((window_bottom > card_top) && (window_top < card_bottom)) {
            card.fadeTo(500, 1, "swing")
        }
    })
}

// Initially show anything in view on page load, and show more on scroll after.
$(document).ready(fadeCardsIn)
$(window).scroll(fadeCardsIn)
