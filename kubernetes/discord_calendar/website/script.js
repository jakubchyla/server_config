async function getEvents()
{
    return fetch('/calendar.json')
        .then((response) => response.json())
        .then((responseJson) => {return responseJson});
}

document.addEventListener('DOMContentLoaded', async function () {
    const calendar = document.getElementById('calendar');
    const prevMonthButton = document.getElementById('prevMonth');
    const nextMonthButton = document.getElementById('nextMonth');
    const currentMonthYear = document.getElementById('currentMonthYear');
    const themeButton = document.getElementById('theme');
    const rootElement = document.documentElement;


    // Pseudo baza danych
    let events = await getEvents();

    // Pobranie pierwszej daty z wydarzeń lub bieżącej daty
    let currentDate = Object.keys(events).length > 0 ? new Date(Object.keys(events)[0]) : new Date();

    // Funkcja renderująca kalendarz
    function renderCalendar(date) {
        calendar.innerHTML = '';
        const year = date.getFullYear();
        const month = date.getMonth();
        const daysInMonth = new Date(year, month + 1, 0).getDate();
        const firstDayOfMonth = new Date(year, month, 1).getDay();

        // Ustawienie pierwszej kolumny na poniedziałek (1), a nie niedzielę (0)
        const firstDayOfWeek = firstDayOfMonth === 0 ? 6 : firstDayOfMonth - 1; // Poniedziałek = 0, Niedziela = 6

        currentMonthYear.textContent = `${getMonthName(month)} ${year}`;

        // Dodaj puste komórki dla dni poprzedniego miesiąca
        for (let i = 0; i < firstDayOfWeek; i++) {
            const emptyDay = document.createElement('div');
            emptyDay.className = 'day empty';
            calendar.appendChild(emptyDay);
        }

        // Dodaj dni miesiąca
        for (let i = 1; i <= daysInMonth; i++) {
            const day = document.createElement('div');
            day.className = 'day';
            day.textContent = i;
            day.id = `day-${i}`;
            calendar.appendChild(day);
        }

        highlightEvents(date);
    }

    // Funkcja podświetlająca dni z wydarzeniami
    function highlightEvents(date) {
        const year = date.getFullYear();
        const month = date.getMonth();

        Object.keys(events).forEach(eventDateStr => {
            const eventDate = new Date(eventDateStr);
            if (eventDate.getFullYear() === year && eventDate.getMonth() === month) {
                const day = eventDate.getDate();
                const dayElement = document.getElementById(`day-${day}`);
                if (dayElement) {
                    dayElement.classList.add('has-event');
                    const eventList = events[eventDateStr];
                    const tooltipContent = eventList.map(event =>
                        `${event.title}\n${event.description}\nGodzina: ${event.time}`
                    ).join('\n\n');
                    dayElement.setAttribute('data-tooltip', tooltipContent);
                }
            }
        });
    }

    // Obsługa przycisku "Poprzedni miesiąc"
    prevMonthButton.addEventListener('click', function () {
        currentDate.setMonth(currentDate.getMonth() - 1);
        renderCalendar(currentDate);
    });

    // Obsługa przycisku "Następny miesiąc"
    nextMonthButton.addEventListener('click', function () {
        currentDate.setMonth(currentDate.getMonth() + 1);
        renderCalendar(currentDate);
    });

    // Funkcja zwracająca nazwę miesiąca
    function getMonthName(monthIndex) {
        const months = [
            'Styczeń', 'Luty', 'Marzec', 'Kwiecień', 'Maj', 'Czerwiec',
            'Lipiec', 'Sierpień', 'Wrzesień', 'Październik', 'Listopad', 'Grudzień'
        ];
        return months[monthIndex];
    }

    // Funkcja do zmiany motywu
    function toggleTheme() {
        const currentTheme = rootElement.getAttribute('data-theme');
        if (currentTheme === 'dark') {
            rootElement.removeAttribute('data-theme');
            localStorage.setItem('theme', 'light'); // Zapisz motyw jasny
        } else {
            rootElement.setAttribute('data-theme', 'dark');
            localStorage.setItem('theme', 'dark'); // Zapisz motyw ciemny
        }
    }

    // Sprawdzenie zapisanego motywu w localStorage
    const savedTheme = localStorage.getItem('theme');
    if (savedTheme === 'dark') {
        rootElement.setAttribute('data-theme', 'dark'); // Ustaw motyw ciemny
    } else {
        rootElement.removeAttribute('data-theme'); // Ustaw motyw jasny
    }

    // Przypisanie funkcji do przycisku
    themeButton.addEventListener('click', toggleTheme);

    // Uruchomienie strony z pierwszym wydarzeniem
    renderCalendar(currentDate);
});
