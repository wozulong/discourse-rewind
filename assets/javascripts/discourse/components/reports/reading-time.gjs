import Component from "@glimmer/component";

export default class ReadingTime extends Component {
  get readTimeString() {
    let totalMinutes = Math.floor(this.args.report.data.reading_time / 60);
    let leftOverMinutes = totalMinutes % 60;
    let totalHours = (totalMinutes - leftOverMinutes) / 60;

    return `${totalHours}h ${leftOverMinutes}m`;
  }

  <template>
    <div class="rewind-report-page -reading-time">
      <div class="rewind-report-container">
        <p class="reading-time__text">You spent
          <code>{{this.readTimeString}}</code>
          reading on our site! That's the time it would take to read through
          <i>{{@report.data.book}}</i></p>
        <div class="reading-time__book">
          <div class="book">
            <img
              alt=""
              src="/plugins/discourse-rewind/images/books/978-0451524935.jpg"
            />
          </div>
        </div>
      </div>
    </div>
  </template>
}
