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
        <h3 class="rewind-report-title">Activity Calendar</h3>
        <table class="rewind-calendar">
          <thead>
            <tr>
              <td colspan="5" class="activity-header-cell">Jan</td>
              <td colspan="4" class="activity-header-cell">Feb</td>
              <td colspan="4" class="activity-header-cell">Mar</td>
              <td colspan="5" class="activity-header-cell">Apr</td>
              <td colspan="4" class="activity-header-cell">May</td>
              <td colspan="4" class="activity-header-cell">Jun</td>
              <td colspan="5" class="activity-header-cell">Jul</td>
              <td colspan="4" class="activity-header-cell">Aug</td>
              <td colspan="5" class="activity-header-cell">Sep</td>
              <td colspan="4" class="activity-header-cell">Oct</td>
              <td colspan="4" class="activity-header-cell">Nov</td>
              <td colspan="4" class="activity-header-cell">Dec</td>
            </tr>
          </thead>
          <tbody>
            {{#each this.rowsArray as |row|}}
              <tr>
                {{#each row as |cell|}}
                  <td
                    data-date={{cell.date}}
                    title={{cell.date}}
                    class={{concatClass
                      "rewind-calendar-cell"
                      (this.computeClass cell.post_count)
                    }}
                  ></td>
                {{/each}}
              </tr>
            {{/each}}
          </tbody>
        </table>
      </div>
    </div>
  </template>
}
