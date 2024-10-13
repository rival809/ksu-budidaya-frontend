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
                        onPressed: () {
                          router.go("/transaksi/penjualan");
                        },
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
                        return const ContainerLoadingRole();
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const ContainerError();
                        } else if (snapshot.hasData) {
                          List<PlutoRow> rows = [];
                          List<PlutoColumn> columns = [];
                          PenjualanResult result = snapshot.data;
                          controller.dataListPenjualan =
                              result.data ?? DataPenjualan();
                          List<dynamic> listData = controller.dataListPenjualan
                                  .toJson()["data_penjualan"] ??
                              [];

                          if (listData.isNotEmpty) {
                            columns.addAll(
                              List.generate(
                                controller.listPenjualanView.length,
                                (index) {
                                  if (controller.listPenjualanView[index] ==
                                      "jumlah") {
                                    return PlutoColumn(
                                      width: 75,
                                      backgroundColor: primaryColor,
                                      filterHintText: "Cari Jumlah Barang",
                                      title: "JUMLAH BARANG",
                                      textAlign: PlutoColumnTextAlign.center,
                                      field:
                                          controller.listPenjualanView[index],
                                      type: PlutoColumnType.number(
                                        locale: "id",
                                      ),
                                    );
                                  }
                                  if (controller.listPenjualanView[index] ==
                                      "total_nilai_jual") {
                                    return PlutoColumn(
                                      width: 75,
                                      backgroundColor: primaryColor,
                                      filterHintText: "Cari Total Pembayaran",
                                      title: "TOTAL PEMBAYARAN",
                                      textAlign: PlutoColumnTextAlign.end,
                                      field:
                                          controller.listPenjualanView[index],
                                      type: PlutoColumnType.number(
                                        locale: "id",
                                      ),
                                    );
                                  }
                                  if (controller.listPenjualanView[index] ==
                                      "total_nilai_beli") {
                                    return PlutoColumn(
                                      width: 75,
                                      backgroundColor: primaryColor,
                                      filterHintText: "Cari Keuntungan",
                                      title: "KEUNTUNGAN",
                                      field:
                                          controller.listPenjualanView[index],
                                      type: PlutoColumnType.number(
                                        locale: "id",
                                      ),
                                      renderer: (rendererContext) {
                                        var data = rendererContext.row.toJson();
                                        String idPenjualan =
                                            data["id_penjualan"];
                                        String? keutungan;

                                        for (var i = 0;
                                            i <
                                                (controller
                                                        .dataListPenjualan
                                                        .dataPenjualan
                                                        ?.length ??
                                                    0);
                                            i++) {
                                          if (trimString(idPenjualan) ==
                                              trimString(controller
                                                  .dataListPenjualan
                                                  .dataPenjualan?[i]
                                                  .idPenjualan)) {
                                            var hitKeuntungan = double.parse(
                                                    controller
                                                            .dataListPenjualan
                                                            .dataPenjualan?[i]
                                                            .totalNilaiJual ??
                                                        "0") -
                                                double.parse(controller
                                                        .dataListPenjualan
                                                        .dataPenjualan?[i]
                                                        .totalNilaiBeli ??
                                                    "0");
                                            keutungan =
                                                hitKeuntungan.toString();
                                          }
                                        }
                                        return Text(
                                          formatMoney(keutungan),
                                          textAlign: TextAlign.end,
                                        );
                                      },
                                    );
                                  }
                                  return PlutoColumn(
                                    backgroundColor: primaryColor,
                                    filterHintText: controller
                                                .listPenjualanView[index] ==
                                            "id_penjualan"
                                        ? "Cari ID Transaksi"
                                        : controller.listPenjualanView[index] ==
                                                "nm_anggota"
                                            ? "Cari Pembeli"
                                            : controller.listPenjualanView[
                                                        index] ==
                                                    "username"
                                                ? "Cari Kasir"
                                                : "Cari ${controller.listPenjualanView[index]}",
                                    title: controller
                                                .listPenjualanView[index] ==
                                            "id_penjualan"
                                        ? "ID TRANSAKSI"
                                        : controller.listPenjualanView[index] ==
                                                "nm_anggota"
                                            ? "PEMBELI"
                                            : controller.listPenjualanView[
                                                        index] ==
                                                    "username"
                                                ? "KASIR"
                                                : convertTitle(
                                                    controller
                                                            .listPenjualanView[
                                                        index],
                                                  ),
                                    field: controller.listPenjualanView[index],
                                    type: PlutoColumnType.text(),
                                  );
                                },
                              ),
                            );

                            List<dynamic> listDataWithIndex =
                                List.generate(listData.length, (index) {
                              return {
                                ...listData[index],
                                'persistentIndex': index + 1,
                              };
                            });
                            rows = listDataWithIndex.map((item) {
                              Map<String, PlutoCell> cells = {};

                              cells['Aksi'] = PlutoCell(
                                value: null,
                              );

                              for (String column
                                  in controller.listPenjualanView) {
                                if (item.containsKey(column)) {
                                  cells[column] = PlutoCell(
                                    value: column == "id_supplier"
                                        ? getNamaSupplier(
                                            idSupplier: trimString(
                                            item[column].toString(),
                                          ))
                                        : trimStringStrip(
                                            item[column].toString(),
                                          ),
                                  );
                                }
                              }

                              return PlutoRow(cells: cells);
                            }).toList();
                            double rowHeight = 47.5;

                            return SizedBox(
                              height: (rows.length * rowHeight) + rowHeight,
                              child: PlutoGrid(
                                noRowsWidget: const ContainerTidakAda(
                                  entity: 'Penjualan',
                                ),
                                mode: PlutoGridMode.select,
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
                                  ),
                                  localeText: configLocale,
                                ),
                                columns: columns,
                                rows: rows,
                              ),
                            );
                          } else {
                            return const SizedBox(
                              height: 100,
                              child: ContainerTidakAda(
                                entity: 'Penjualan',
                              ),
                            );
                          }
                        } else {
                          return const SizedBox(
                            height: 100,
                            child: ContainerError(),
                          );
                        }
                      } else {
                        return const SizedBox(
                          height: 100,
                          child: ContainerTidakAda(
                            entity: "Penjualan",
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
