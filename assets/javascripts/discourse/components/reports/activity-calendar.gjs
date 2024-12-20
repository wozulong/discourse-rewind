import Component from "@glimmer/component";
import { action } from "@ember/object";
import concatClass from "discourse/helpers/concat-class";

const ROWS = 7;
const COLS = 53;

export default class ActivityCalendar extends Component {
  get rowsArray() {
    const data = this.args.report.data;
    let rowsArray = [];

    for (let r = 0; r < ROWS; r++) {
      let rowData = [];
      for (let c = 0; c < COLS; c++) {
        const index = c * ROWS + r;
        rowData.push(data[index] ? data[index] : "");
      }
      rowsArray.push(rowData);
    }

    return rowsArray;
  }

  @action
  computeClass(count) {
    if (!count) {
      return "-empty";
    } else if (count < 10) {
      return "-low";
    } else if (count < 20) {
      return "-medium";
    } else {
      return "-high";
    }
  }

  <template>
    <div class="rewind-report-page -activity-calendar">
      <div class="rewind-card">
        <table class="rewind-calendar">
          {{#each this.rowsArray as |row|}}
            <tr>
              {{#each row as |cell|}}
                <td
                  data-date={{cell.date}}
                  class={{concatClass
                    "rewind-calendar-cell"
                    (this.computeClass cell.post_count)
                  }}
                ></td>
              {{/each}}
            </tr>
          {{/each}}
        </table>
      </div>
    </div>
  </template>
}
