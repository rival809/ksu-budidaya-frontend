// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ContentBeranda extends StatefulWidget {
  final BerandaController controller;
  const ContentBeranda({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<ContentBeranda> createState() => _ContentBerandaState();
}

class _ContentBerandaState extends State<ContentBeranda> {
  @override
  Widget build(BuildContext context) {
    BerandaController controller = widget.controller;
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Skeletonizer(
        enabled: controller.loading,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: neutralWhite,
                border: Border.all(
                  width: 1.0,
                  color: blueGray50,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dashboard",
                    style: myTextTheme.headlineLarge,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "Selamat Datang, ${trimString(UserDatabase.userDatabase.data?.userData?.name)}",
                    style: myTextTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            ScreenTypeLayout.builder(
              mobile: (p0) => Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: neutralWhite,
                      border: Border.all(
                        width: 1.0,
                        color: blueGray50,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pendapatan Hari Ini",
                                style: myTextTheme.bodyLarge?.copyWith(
                                  color: gray700,
                                ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Rp. ${formatMoney(controller.resultDashboard.data?.totalIncomeToday.toString())}",
                                      style: myTextTheme.displayLarge?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  if (controller
                                          .resultDashboard.data?.percentage !=
                                      null)
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          isPositive(controller.resultDashboard
                                                      .data?.percentage ??
                                                  0)
                                              ? iconArrowDropUp
                                              : iconArrowDropDown,
                                          colorFilter: isPositive(controller
                                                      .resultDashboard
                                                      .data
                                                      ?.percentage ??
                                                  0)
                                              ? colorFilterPrimary
                                              : colorFilterRed800,
                                          width: 24,
                                        ),
                                        const SizedBox(
                                          width: 8.0,
                                        ),
                                        Text(
                                          "${formatMoney(controller.resultDashboard.data?.percentage.toString())} %",
                                          style:
                                              myTextTheme.titleMedium?.copyWith(
                                            color: isPositive(controller
                                                        .resultDashboard
                                                        .data
                                                        ?.percentage ??
                                                    0)
                                                ? primaryColor
                                                : red800,
                                          ),
                                        ),
                                      ],
                                    )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: green50,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          child: SvgPicture.asset(
                            iconAccountBalanceWallet,
                            colorFilter: colorFilterPrimary,
                            width: 40,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: neutralWhite,
                      border: Border.all(
                        width: 1.0,
                        color: blueGray50,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pendapatan Kemarin",
                                style: myTextTheme.bodyLarge?.copyWith(
                                  color: gray700,
                                ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Rp. ${formatMoney(controller.resultDashboard.data?.totalIncomeYesterday.toString())}",
                                      style: myTextTheme.displayLarge?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: green50,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          child: SvgPicture.asset(
                            iconAccountBalanceWallet,
                            colorFilter: colorFilterPrimary,
                            width: 40,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              desktop: (p0) => Row(
                children: [
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: neutralWhite,
                        border: Border.all(
                          width: 1.0,
                          color: blueGray50,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Pendapatan Hari Ini",
                                  style: myTextTheme.bodyLarge?.copyWith(
                                    color: gray700,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Rp. ${formatMoney(controller.resultDashboard.data?.totalIncomeToday.toString())}",
                                        style:
                                            myTextTheme.displayLarge?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    if (controller
                                            .resultDashboard.data?.percentage !=
                                        null)
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            isPositive(controller
                                                        .resultDashboard
                                                        .data
                                                        ?.percentage ??
                                                    0)
                                                ? iconArrowDropUp
                                                : iconArrowDropDown,
                                            colorFilter: isPositive(controller
                                                        .resultDashboard
                                                        .data
                                                        ?.percentage ??
                                                    0)
                                                ? colorFilterPrimary
                                                : colorFilterRed800,
                                            width: 24,
                                          ),
                                          const SizedBox(
                                            width: 8.0,
                                          ),
                                          Text(
                                            "${formatMoney(controller.resultDashboard.data?.percentage.toString())} %",
                                            style: myTextTheme.titleMedium
                                                ?.copyWith(
                                              color: isPositive(controller
                                                          .resultDashboard
                                                          .data
                                                          ?.percentage ??
                                                      0)
                                                  ? primaryColor
                                                  : red800,
                                            ),
                                          ),
                                        ],
                                      )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: green50,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                            ),
                            child: SvgPicture.asset(
                              iconAccountBalanceWallet,
                              colorFilter: colorFilterPrimary,
                              width: 40,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: neutralWhite,
                        border: Border.all(
                          width: 1.0,
                          color: blueGray50,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Pendapatan Kemarin",
                                  style: myTextTheme.bodyLarge?.copyWith(
                                    color: gray700,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Rp. ${formatMoney(controller.resultDashboard.data?.totalIncomeYesterday.toString())}",
                                        style:
                                            myTextTheme.displayLarge?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: green50,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                            ),
                            child: SvgPicture.asset(
                              iconAccountBalanceWallet,
                              colorFilter: colorFilterPrimary,
                              width: 40,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //////Monthly
            const SizedBox(
              height: 24.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: neutralWhite,
                border: Border.all(
                  width: 1.0,
                  color: blueGray50,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Statistik Bulanan",
                          style: myTextTheme.headlineLarge,
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: BaseDropdownButton<Month>(
                          sortItem: false,
                          itemAsString: (item) => item.monthAsString(),
                          items: Year.fromJson(monthData).months,
                          value: Month(
                            id: controller.monthNow,
                            month: trimString(
                                controller.getNamaMonth(controller.monthNow)),
                          ),
                          onChanged: (value) {
                            controller.monthNow = value?.id ?? 1;
                            controller.update();
                            controller.postIncomeMonthly();
                            controller.update();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  ScreenTypeLayout.builder(
                    mobile: (p0) => Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: neutralWhite,
                            border: Border.all(
                              width: 1.0,
                              color: blueGray50,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Pendapatan",
                                style: myTextTheme.bodyLarge?.copyWith(
                                  color: gray700,
                                ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Rp. ${formatMoney(controller.resultMonthly.data?.totalIncome.toString())}",
                                      style: myTextTheme.displayLarge?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  if (controller.resultMonthly.data
                                          ?.percentageIncome !=
                                      null)
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          isPositive(controller.resultMonthly
                                                      .data?.percentageIncome ??
                                                  0)
                                              ? iconArrowDropUp
                                              : iconArrowDropDown,
                                          colorFilter: isPositive(controller
                                                      .resultMonthly
                                                      .data
                                                      ?.percentageIncome ??
                                                  0)
                                              ? colorFilterPrimary
                                              : colorFilterRed800,
                                          width: 24,
                                        ),
                                        const SizedBox(
                                          width: 8.0,
                                        ),
                                        Text(
                                          "${formatMoney(controller.resultMonthly.data?.percentageIncome.toString())} %",
                                          style:
                                              myTextTheme.titleMedium?.copyWith(
                                            color: isPositive(controller
                                                        .resultMonthly
                                                        .data
                                                        ?.percentageIncome ??
                                                    0)
                                                ? primaryColor
                                                : red800,
                                          ),
                                        ),
                                      ],
                                    )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: neutralWhite,
                            border: Border.all(
                              width: 1.0,
                              color: blueGray50,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Pengeluaran",
                                style: myTextTheme.bodyLarge?.copyWith(
                                  color: gray700,
                                ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Rp. ${formatMoney(controller.resultMonthly.data?.totalExpense.toString())}",
                                      style: myTextTheme.displayLarge?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  if (controller.resultMonthly.data
                                          ?.percentageExpense !=
                                      null)
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          isPositive(controller
                                                      .resultMonthly
                                                      .data
                                                      ?.percentageExpense ??
                                                  0)
                                              ? iconArrowDropUp
                                              : iconArrowDropDown,
                                          colorFilter: isPositive(controller
                                                      .resultMonthly
                                                      .data
                                                      ?.percentageExpense ??
                                                  0)
                                              ? colorFilterPrimary
                                              : colorFilterRed800,
                                          width: 24,
                                        ),
                                        const SizedBox(
                                          width: 8.0,
                                        ),
                                        Text(
                                          "${formatMoney(controller.resultMonthly.data?.percentageExpense.toString())} %",
                                          style:
                                              myTextTheme.titleMedium?.copyWith(
                                            color: isPositive(controller
                                                        .resultMonthly
                                                        .data
                                                        ?.percentageExpense ??
                                                    0)
                                                ? primaryColor
                                                : red800,
                                          ),
                                        ),
                                      ],
                                    )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: neutralWhite,
                            border: Border.all(
                              width: 1.0,
                              color: blueGray50,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Keuntungan",
                                style: myTextTheme.bodyLarge?.copyWith(
                                  color: gray700,
                                ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Rp. ${formatMoney(controller.resultMonthly.data?.totalProfit.toString())}",
                                      style: myTextTheme.displayLarge?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  if (controller.resultMonthly.data
                                          ?.percentageProfit !=
                                      null)
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          isPositive(controller.resultMonthly
                                                      .data?.percentageProfit ??
                                                  0)
                                              ? iconArrowDropUp
                                              : iconArrowDropDown,
                                          colorFilter: isPositive(controller
                                                      .resultMonthly
                                                      .data
                                                      ?.percentageProfit ??
                                                  0)
                                              ? colorFilterPrimary
                                              : colorFilterRed800,
                                          width: 24,
                                        ),
                                        const SizedBox(
                                          width: 8.0,
                                        ),
                                        Text(
                                          "${formatMoney(controller.resultMonthly.data?.percentageProfit.toString())} %",
                                          style:
                                              myTextTheme.titleMedium?.copyWith(
                                            color: isPositive(controller
                                                        .resultMonthly
                                                        .data
                                                        ?.percentageProfit ??
                                                    0)
                                                ? primaryColor
                                                : red700,
                                          ),
                                        ),
                                      ],
                                    )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    desktop: (p0) => Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: neutralWhite,
                              border: Border.all(
                                width: 1.0,
                                color: blueGray50,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Pendapatan",
                                  style: myTextTheme.bodyLarge?.copyWith(
                                    color: gray700,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Rp. ${formatMoney(controller.resultMonthly.data?.totalIncome.toString())}",
                                        style:
                                            myTextTheme.displayLarge?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    if (controller.resultMonthly.data
                                            ?.percentageIncome !=
                                        null)
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            isPositive(controller
                                                        .resultMonthly
                                                        .data
                                                        ?.percentageIncome ??
                                                    0)
                                                ? iconArrowDropUp
                                                : iconArrowDropDown,
                                            colorFilter: isPositive(controller
                                                        .resultMonthly
                                                        .data
                                                        ?.percentageIncome ??
                                                    0)
                                                ? colorFilterPrimary
                                                : colorFilterRed800,
                                            width: 24,
                                          ),
                                          const SizedBox(
                                            width: 8.0,
                                          ),
                                          Text(
                                            "${formatMoney(controller.resultMonthly.data?.percentageIncome.toString())} %",
                                            style: myTextTheme.titleMedium
                                                ?.copyWith(
                                              color: isPositive(controller
                                                          .resultMonthly
                                                          .data
                                                          ?.percentageIncome ??
                                                      0)
                                                  ? primaryColor
                                                  : red800,
                                            ),
                                          ),
                                        ],
                                      )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: neutralWhite,
                              border: Border.all(
                                width: 1.0,
                                color: blueGray50,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Pengeluaran",
                                  style: myTextTheme.bodyLarge?.copyWith(
                                    color: gray700,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Rp. ${formatMoney(controller.resultMonthly.data?.totalExpense.toString())}",
                                        style:
                                            myTextTheme.displayLarge?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    if (controller.resultMonthly.data
                                            ?.percentageExpense !=
                                        null)
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            isPositive(controller
                                                        .resultMonthly
                                                        .data
                                                        ?.percentageExpense ??
                                                    0)
                                                ? iconArrowDropUp
                                                : iconArrowDropDown,
                                            colorFilter: isPositive(controller
                                                        .resultMonthly
                                                        .data
                                                        ?.percentageExpense ??
                                                    0)
                                                ? colorFilterPrimary
                                                : colorFilterRed800,
                                            width: 24,
                                          ),
                                          const SizedBox(
                                            width: 8.0,
                                          ),
                                          Text(
                                            "${formatMoney(controller.resultMonthly.data?.percentageExpense.toString())} %",
                                            style: myTextTheme.titleMedium
                                                ?.copyWith(
                                              color: isPositive(controller
                                                          .resultMonthly
                                                          .data
                                                          ?.percentageExpense ??
                                                      0)
                                                  ? primaryColor
                                                  : red800,
                                            ),
                                          ),
                                        ],
                                      )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: neutralWhite,
                              border: Border.all(
                                width: 1.0,
                                color: blueGray50,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Keuntungan",
                                  style: myTextTheme.bodyLarge?.copyWith(
                                    color: gray700,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Rp. ${formatMoney(controller.resultMonthly.data?.totalProfit.toString())}",
                                        style:
                                            myTextTheme.displayLarge?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    if (controller.resultMonthly.data
                                            ?.percentageProfit !=
                                        null)
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            isPositive(controller
                                                        .resultMonthly
                                                        .data
                                                        ?.percentageProfit ??
                                                    0)
                                                ? iconArrowDropUp
                                                : iconArrowDropDown,
                                            colorFilter: isPositive(controller
                                                        .resultMonthly
                                                        .data
                                                        ?.percentageProfit ??
                                                    0)
                                                ? colorFilterPrimary
                                                : colorFilterRed800,
                                            width: 24,
                                          ),
                                          const SizedBox(
                                            width: 8.0,
                                          ),
                                          Text(
                                            "${formatMoney(controller.resultMonthly.data?.percentageProfit.toString())} %",
                                            style: myTextTheme.titleMedium
                                                ?.copyWith(
                                              color: isPositive(controller
                                                          .resultMonthly
                                                          .data
                                                          ?.percentageProfit ??
                                                      0)
                                                  ? primaryColor
                                                  : red700,
                                            ),
                                          ),
                                        ],
                                      )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: neutralWhite,
                border: Border.all(
                  width: 1.0,
                  color: blueGray50,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Riwayat Penjualan",
                          style: myTextTheme.headlineLarge,
                        ),
                      ),
                      BaseTertiaryButton(
                        isDense: true,
                        text: "Lihat Lainnya",
                        suffixIcon: iconChevronKanan,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  FutureBuilder(
                    future: controller.dataFuture,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: Text("Loading"),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text("Error"),
                          );
                        } else if (snapshot.hasData) {
                          // EditVerifResult result = snapshot.data;
                          // controller.dataEdit = result.data ?? DataEditVerif();
                          // List<dynamic> listData =
                          //     controller.dataEdit.items ?? [];

                          List<PlutoRow> rows = [];
                          List<PlutoColumn> columns = [];

                          return SizedBox(
                            height: MediaQuery.of(context).size.height -
                                AppBar().preferredSize.height -
                                144,
                            child: PlutoGrid(
                              noRowsWidget: const Center(
                                child: Text("Tidak Ada Data"),
                              ),
                              mode: PlutoGridMode.select,
                              onLoaded: (event) {
                                event.stateManager.setShowColumnFilter(true);
                              },
                              onSorted: (event) {
                                if (event.column.field != "Aksi") {
                                  // controller.isAsc = !controller.isAsc;
                                  // controller.update();
                                  // controller.dataFuture =
                                  //     controller.cariEditTable(
                                  //         event.column.field, controller.isAsc);
                                  // controller.update();
                                }
                              },
                              configuration: PlutoGridConfiguration(
                                columnSize: const PlutoGridColumnSizeConfig(
                                  autoSizeMode: PlutoAutoSizeMode.none,
                                ),
                                style: PlutoGridStyleConfig(
                                  gridBorderColor: blueGray50,
                                  gridBorderRadius: BorderRadius.circular(8),
                                ),
                                localeText: configLocale,
                              ),
                              columns: columns,
                              rows: rows,
                              // createFooter: (stateManager) {
                              //   return FooterCariVerif(
                              //     controller: controller,
                              //     isMobile: true,
                              //   );
                              // },
                            ),
                          );
                        } else {
                          return const Center(
                            child: Text("Error"),
                          );
                        }
                      } else {
                        List<PlutoColumn> columns = [
                          /// Text Column definition
                          PlutoColumn(
                            backgroundColor: primaryColor,
                            title: 'ID Transaksi',
                            field: 'id_transaksi',
                            type: PlutoColumnType.text(),
                          ),

                          /// Number Column definition
                          PlutoColumn(
                            backgroundColor: primaryColor,
                            title: 'Jumlah Barang',
                            field: 'jumlah_barang',
                            textAlign: PlutoColumnTextAlign.center,
                            type: PlutoColumnType.number(),
                          ),

                          /// Select Column definition
                          PlutoColumn(
                            backgroundColor: primaryColor,
                            title: 'Total Pembayaran',
                            field: 'total_pembayaran',
                            textAlign: PlutoColumnTextAlign.end,
                            type: PlutoColumnType.number(format: "#,###"),
                          ),
                          // Datetime Column definition
                          PlutoColumn(
                            backgroundColor: primaryColor,
                            title: 'Keuntungan',
                            field: 'keuntungan',
                            textAlign: PlutoColumnTextAlign.end,
                            type: PlutoColumnType.number(format: "#,###"),
                          ),

                          /// Time Column definition
                          PlutoColumn(
                            backgroundColor: primaryColor,
                            title: 'Pembeli',
                            field: 'pembeli',
                            type: PlutoColumnType.text(),
                          ),
                          PlutoColumn(
                            backgroundColor: primaryColor,
                            title: 'Kasir',
                            field: 'kasir',
                            type: PlutoColumnType.text(),
                          ),
                        ];

                        List<PlutoRow> rows = [
                          PlutoRow(
                            cells: {
                              'id_transaksi': PlutoCell(value: 'J-000001740'),
                              'jumlah_barang': PlutoCell(value: 10),
                              'total_pembayaran': PlutoCell(value: 100000),
                              'keuntungan': PlutoCell(value: 25000),
                              'pembeli': PlutoCell(value: 'IRWAN'),
                              'kasir': PlutoCell(value: 'IRWAN'),
                            },
                          ),
                          PlutoRow(
                            cells: {
                              'id_transaksi': PlutoCell(value: 'J-000001740'),
                              'jumlah_barang': PlutoCell(value: 10),
                              'total_pembayaran': PlutoCell(value: 100000),
                              'keuntungan': PlutoCell(value: 25000),
                              'pembeli': PlutoCell(value: 'IRWAN'),
                              'kasir': PlutoCell(value: 'IRWAN'),
                            },
                          ),
                        ];
                        double rowHeight = 45.0;
                        return SizedBox(
                          height: (rows.length * rowHeight) + rowHeight * 2,
                          child: PlutoGrid(
                            noRowsWidget: const Center(
                              child: Text("Tidak Ada Data"),
                            ),
                            mode: PlutoGridMode.select,
                            onLoaded: (event) {
                              event.stateManager.setShowColumnFilter(true);
                            },
                            onSorted: (event) {
                              if (event.column.field != "Aksi") {
                                // controller.isAsc = !controller.isAsc;
                                // controller.update();
                                // controller.dataFuture =
                                //     controller.cariEditTable(
                                //         event.column.field, controller.isAsc);
                                // controller.update();
                              }
                            },
                            configuration: PlutoGridConfiguration(
                              columnSize: const PlutoGridColumnSizeConfig(
                                autoSizeMode: PlutoAutoSizeMode.scale,
                              ),
                              style: PlutoGridStyleConfig(
                                columnTextStyle: myTextTheme.titleSmall
                                        ?.copyWith(color: neutralWhite) ??
                                    const TextStyle(),
                                gridBorderColor: blueGray50,
                                gridBorderRadius: BorderRadius.circular(8),
                                evenRowColor: gray50,
                              ),
                              localeText: configLocale,
                            ),

                            columns: columns,
                            rows: rows,
                            // createFooter: (stateManager) {
                            //   return FooterCariVerif(
                            //     controller: controller,
                            //     isMobile: true,
                            //   );
                            // },
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
