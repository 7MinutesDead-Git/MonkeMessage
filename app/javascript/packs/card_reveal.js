
function fadeCardsIn() {
    const window_top = $(window).scrollTop()
    const window_bottom = $(window).scrollTop() + $(window).innerHeight()
    const cards = $(".card")

    // Add event listener to each card
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

// Add event listener to each card, that fires when element is in view.
$(document).ready(fadeCardsIn)
$(window).scroll(fadeCardsIn)